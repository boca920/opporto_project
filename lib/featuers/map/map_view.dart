import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:opporto_project/core/utils/app_colors.dart';
import 'package:opporto_project/core/utils/app_fonts.dart';

class FreeMapWithSearch extends StatefulWidget {
  const FreeMapWithSearch({super.key});

  @override
  State<FreeMapWithSearch> createState() => _FreeMapWithSearchState();
}

class _FreeMapWithSearchState extends State<FreeMapWithSearch> {
  LatLng _selectedLocation = LatLng(30.0444, 31.2357);
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  String? _selectedAddress;


  List<String> _suggestions = [];


  Future<void> _getAddress(LatLng position) async {
    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          _selectedAddress =
          "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
        });
      }
    } catch (e) {
      setState(() {
        _selectedAddress = "Address not found";
      });
    }
  }


  Future<void> _updateSuggestions(String input) async {
    if (input.isEmpty) {
      setState(() {
        _suggestions = [];
      });
      return;
    }

    try {
      List<Location> locations = await locationFromAddress(input);
      setState(() {
        _suggestions = locations
            .map((loc) =>
        "${loc.latitude.toStringAsFixed(5)}, ${loc.longitude.toStringAsFixed(5)}")
            .toList();
      });
    } catch (e) {
      setState(() {
        _suggestions = [];
      });
    }
  }

  Future<void> _selectSuggestion(String suggestion) async {
    List<String> parts = suggestion.split(",");
    double lat = double.parse(parts[0]);
    double lng = double.parse(parts[1]);
    LatLng newPosition = LatLng(lat, lng);

    setState(() {
      _selectedLocation = newPosition;
      _searchController.text = suggestion;
      _suggestions = [];
    });

    _mapController.move(newPosition, 16);
    await _getAddress(newPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Select Location",style: AppFonts.whiteSemiBold18,),
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.movColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      backgroundColor: AppColors.movColor,

      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: _selectedLocation,
              zoom: 14.0,
              onTap: (tapPosition, point) async {
                setState(() {
                  _selectedLocation = point;
                });
                await _getAddress(point);
              },
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: 'com.example.opporto_project',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _selectedLocation,
                    width: 40,
                    height: 40,
                    builder: (_) => const Icon(
                      Icons.location_pin,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // TextField للبحث
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Column(
              children: [
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search location...",
                      prefixIcon: const Icon(Icons.search),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(15),
                    ),
                    onChanged: _updateSuggestions,
                  ),
                ),
                // عرض الاقتراحات
                if (_suggestions.isNotEmpty)
                  Container(
                    color: Colors.white,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _suggestions.length,
                      itemBuilder: (context, index) {
                        String suggestion = _suggestions[index];
                        return ListTile(
                          leading: const Icon(Icons.location_on),
                          title: Text(suggestion),
                          onTap: () => _selectSuggestion(suggestion),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),

          // عرض العنوان المحدد
          if (_selectedAddress != null)
            Positioned(
              bottom: 80,
              left: 15,
              right: 15,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _selectedAddress!,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context, {
            "latLng": _selectedLocation,
            "address": _selectedAddress,
          });
        },
        backgroundColor: AppColors.movColor, // لون موف Purple / Mauve
        label: Text(
          "Confirm",
          style: AppFonts.whiteRegular16,
        ),
        icon:  Icon(Icons.check,color: AppColors.whiteColor,),
      ),
    );
  }
}