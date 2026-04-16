import 'dart:async';

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

  Timer? _debounce; // ✅ مهم جدًا

  // ==============================
  // 📍 Get Address
  // ==============================
  Future<void> _getAddress(LatLng position) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (!mounted) return;

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        setState(() {
          _selectedAddress =
          "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _selectedAddress = "Address not found";
        });
      }
    }
  }


  void _updateSuggestions(String input) {

    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () async {

      if (input.isEmpty || input.length < 3) {
        if (mounted) {
          setState(() => _suggestions = []);
        }
        return;
      }

      try {
        final locations = await locationFromAddress(input);

        if (!mounted) return;

        setState(() {
          _suggestions = locations
              .map((loc) =>
          "${loc.latitude.toStringAsFixed(5)}, ${loc.longitude.toStringAsFixed(5)}")
              .toList();
        });
      } catch (e) {
        if (mounted) {
          setState(() => _suggestions = []);
        }
      }
    });
  }


  Future<void> _selectSuggestion(String suggestion) async {
    final parts = suggestion.split(",");
    final lat = double.parse(parts[0]);
    final lng = double.parse(parts[1]);

    final newPosition = LatLng(lat, lng);

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
        title: Text("Select Location", style: AppFonts.whiteSemiBold18),
        backgroundColor: AppColors.movColor,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
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
                urlTemplate:
                "https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png",
                subdomains: const ['a', 'b', 'd'],
                maxZoom: 20,
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _selectedLocation,
                    width: 50,
                    height: 50,
                    builder: (_) => const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),


          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _updateSuggestions,
                    decoration: InputDecoration(
                      hintText: "Search location...",
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                      contentPadding: EdgeInsets.all(16),
                    ),
                  ),
                ),


                if (_suggestions.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    constraints: const BoxConstraints(maxHeight: 200),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _suggestions.length,
                      itemBuilder: (context, index) {
                        final suggestion = _suggestions[index];
                        return ListTile(
                          title: Text(suggestion),
                          onTap: () => _selectSuggestion(suggestion),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),


          if (_selectedAddress != null)
            Positioned(
              bottom: 100,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  _selectedAddress!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
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
        backgroundColor: AppColors.movColor,
        label: Text("Confirm", style: AppFonts.whitemedium16),
        icon: const Icon(Icons.check),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  @override
  void dispose() {
    _debounce?.cancel(); // ✅ مهم جدًا
    _searchController.dispose();
    super.dispose();
  }
}