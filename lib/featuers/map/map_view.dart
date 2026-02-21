import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:opporto_project/core/utils/app_colors.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => _MapSampleState();
}

class _MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _searchController = TextEditingController();

  LatLng? _selectedLocation;
  LatLng? _currentLocation;
  String? _selectedAddress;

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(30.0444, 31.2357),
    zoom: 14,
  );

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    if (!await Geolocator.isLocationServiceEnabled()) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    Position position =
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    _currentLocation = LatLng(position.latitude, position.longitude);

    final controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newLatLngZoom(_currentLocation!, 16),
    );

    setState(() {});
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    List<Placemark> placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);

    Placemark place = placemarks.first;

    _selectedAddress =
    "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
  }

  Future<void> _searchLocation(String value) async {
    List<Location> locations = await locationFromAddress(value);

    if (locations.isNotEmpty) {
      final loc = locations.first;
      LatLng newPosition = LatLng(loc.latitude, loc.longitude);

      final controller = await _controller.future;
      controller.animateCamera(
        CameraUpdate.newLatLngZoom(newPosition, 16),
      );

      setState(() {
        _selectedLocation = newPosition;
      });

      await _getAddressFromLatLng(newPosition);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(title: const Text("Select Location")),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _initialPosition,
            onMapCreated: (controller) => _controller.complete(controller),
            onTap: (position) async {
              setState(() {
                _selectedLocation = position;
              });
              await _getAddressFromLatLng(position);
            },
            markers: {
              if (_selectedLocation != null)
                Marker(
                  markerId: const MarkerId("selected"),
                  position: _selectedLocation!,
                ),
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),

          /// 🔍 Search Box
          Positioned(
            top: 10,
            left: 15,
            right: 15,
            child: Material(
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
                onSubmitted: _searchLocation,
              ),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_selectedLocation != null) {
            Navigator.pop(context, {
              "latLng": _selectedLocation,
              "address": _selectedAddress
            });
          }
        },
        label: const Text("Confirm"),
        icon: const Icon(Icons.check),
      ),
    );
  }
}