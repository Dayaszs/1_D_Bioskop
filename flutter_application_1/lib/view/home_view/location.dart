import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/constant.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String _currentLocation = "---";
  bool _showPermissionPrompt = true;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _checkInitialPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      setState(() {
        _showPermissionPrompt = false;
      });
      await _getCurrentLocation();
    } else if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      setState(() {
        _showPermissionPrompt = true;
      });
    }
  }

  Future<void> _checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _currentLocation = "Location services are disabled.";
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _currentLocation = "Location permission denied.";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _currentLocation = "Location permissions are permanently denied.";
      });
      return;
    }

    await _getCurrentLocation();
  }

  // Get current location and use Nominatim API to get the address
  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      await _getAddressFromCoordinates(position.latitude, position.longitude);
    } catch (e) {
      setState(() {
        _currentLocation = "Failed to get location: $e";
      });
    }
  }

  // Call Nominatim API to get the address based on coordinates
  Future<void> _getAddressFromCoordinates(double latitude, double longitude) async {
    final url = 'https://nominatim.openstreetmap.org/reverse?lat=$latitude&lon=$longitude&format=json';
    
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'User-Agent': 'YourAppName/1.0 (your-email@example.com)',  // Update with your app info
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _currentLocation = data['display_name'] ?? 'Address not found';
        });
      } else {
        setState(() {
          _currentLocation = 'Failed to get address';
        });
      }
    } catch (e) {
      setState(() {
        _currentLocation = 'Error: $e';
      });
    }
  }

  void _handleAllow() async {
    await _checkLocationPermission();
    setState(() {
      _showPermissionPrompt = false;
    });
  }

  void _handleDeny() {
    setState(() {
      _currentLocation = "---";
      _showPermissionPrompt = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Location',
          style: TextStyle(
            color: whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 3),
                child: Icon(Icons.arrow_back_ios, color: lightColor),
              ),
              Text(
                'Back',
                style: TextStyle(color: lightColor),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            if (_showPermissionPrompt)
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.blueAccent, size: 24),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Location Is Not Detected\nTurn on your location access to get your current location',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: _handleDeny,
                          child: Text(
                            'Deny',
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ),
                        SizedBox(width: 8),
                        TextButton(
                          onPressed: _handleAllow,
                          child: Text(
                            'Allow',
                            style: TextStyle(color: Colors.yellow),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            if (_showPermissionPrompt) SizedBox(height: 20),
            Text(
              'Your Current Location:',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              _currentLocation,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Divider(color: Colors.grey),
            Expanded(
              child: ListView(
                children: [
                  _buildCityTile('Jakarta'),
                  _buildCityTile('Bandung'),
                  _buildCityTile('Surabaya'),
                  _buildCityTile('Yogyakarta'),
                  _buildCityTile('Bali'),
                  _buildCityTile('Medan'),
                  _buildCityTile('Makassar'),
                  _buildCityTile('Semarang'),
                  _buildCityTile('Palembang'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCityTile(String cityName) {
    return ListTile(
      title: Text(
        cityName,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
      onTap: () {
        // Handle city selection
      },
    );
  }
}
