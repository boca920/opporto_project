import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:opporto_project/core/utils/app_colors.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => _MapSampleState();
}

class _MapSampleState extends State<MapSample> {
  final Completer<gmaps.GoogleMapController> _controller = Completer();
  final TextEditingController _searchController = TextEditingController();

  gmaps.LatLng? _selectedLocation;
  gmaps.LatLng? _currentLocation;
  String? _selectedAddress;

  gmaps.MapType _currentMapType = gmaps.MapType.normal;

  static const String googleApiKey = "AIzaSyBsm431P9XlKxSNezcvHwbHDeDedbc5DNo";
  late FlutterGooglePlacesSdk _places;


  static const gmaps.CameraPosition _initialPosition = gmaps.CameraPosition(
    target: gmaps.LatLng(30.0444, 31.2357),
    zoom: 14,
  );

  @override
  void initState() {
    super.initState();
    _places = FlutterGooglePlacesSdk(googleApiKey);
    _determinePosition();
  }


  Future<void> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    _currentLocation = gmaps.LatLng(position.latitude, position.longitude);
    setState(() {});
  }


  Future<void> _goToCurrentLocation() async {
    if (_currentLocation == null) return;

    final controller = await _controller.future;
    controller.animateCamera(
      gmaps.CameraUpdate.newLatLngZoom(_currentLocation!, 16),
    );
  }

  Future<void> _getAddressFromLatLng(gmaps.LatLng position) async {
    List<Placemark> placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);

    Placemark place = placemarks.first;

    _selectedAddress =
    "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
    setState(() {});
  }

  void _changeMapType() {
    setState(() {
      if (_currentMapType == gmaps.MapType.normal) {
        _currentMapType = gmaps.MapType.satellite;
      } else if (_currentMapType == gmaps.MapType.satellite) {
        _currentMapType = gmaps.MapType.terrain;
      } else {
        _currentMapType = gmaps.MapType.normal;
      }
    });
  }

  Future<void> _searchPlace(String value) async {
    if (value.isEmpty) return;

    final predictions = await _places.findAutocompletePredictions(
      value,
      countries: ['eg'],
    );

    if (predictions.predictions.isNotEmpty) {
      final placeId = predictions.predictions.first.placeId;

      final place = await _places.fetchPlace(
        placeId,
        fields: [PlaceField.Location, PlaceField.Address],
      );

      final lat = place.place?.latLng?.lat;
      final lng = place.place?.latLng?.lng;

      if (lat != null && lng != null) {
        gmaps.LatLng newPosition = gmaps.LatLng(lat, lng);

        final controller = await _controller.future;
        controller.animateCamera(
          gmaps.CameraUpdate.newLatLngZoom(newPosition, 16),
        );

        setState(() {
          _selectedLocation = newPosition;
          _selectedAddress = place.place?.address;
          _searchController.text = place.place?.address ?? '';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: const Text("Select Location"),
        actions: [
          IconButton(
            icon: const Icon(Icons.layers),
            onPressed: _changeMapType,
          ),
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _goToCurrentLocation,
          ),
        ],
      ),
      body: Stack(
        children: [
          gmaps.GoogleMap(
            initialCameraPosition: _initialPosition,
            mapType: _currentMapType,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: true,
            compassEnabled: true,
            onMapCreated: (controller) => _controller.complete(controller),
            onTap: (position) async {
              setState(() {
                _selectedLocation = position;
              });
              await _getAddressFromLatLng(position);
            },
            markers: {
              if (_selectedLocation != null)
                gmaps.Marker(
                  markerId: const gmaps.MarkerId("selected"),
                  position: _selectedLocation!,
                ),
            },
          ),
          Positioned(
            top: 10,
            left: 15,
            right: 15,
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(10),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: "Search location...",
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(15),
                ),
                onSubmitted: _searchPlace,
              ),
            ),
          ),
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
          if (_selectedLocation != null) {
            Navigator.pop(context, {
              "latLng": _selectedLocation,
              "address": _selectedAddress,
            });
          }
        },
        label: const Text("Confirm"),
        icon: const Icon(Icons.check),
      ),
    );
  }
}