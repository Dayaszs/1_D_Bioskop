import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/constant.dart';
import 'package:geolocator/geolocator.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String _currentLocation = "---";

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _currentLocation = "Location services are disabled.";
      });
      return;
    }

    // Check for permissions
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

    // If permissions are granted, get current location
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentLocation = "Lat: ${position.latitude}, Lon: ${position.longitude}";
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
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.location_on, color: Colors.blueAccent, size: 24),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Location Is Not Detected\nTurn on your location access to get your current location',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ),
                  TextButton(
                    onPressed: _checkLocationPermission,
                    child: Text(
                      'Allow',
                      style: TextStyle(color: Colors.yellow),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
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
