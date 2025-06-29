import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart'; // Suppressed for iOS 13 and below
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Suppressed for iOS 13 and below
import 'dart:io';
import 'package:flutter/foundation.dart'; // Add this import

class PatientLocationWidget extends StatefulWidget {
  const PatientLocationWidget({super.key});

  @override
  State<PatientLocationWidget> createState() => _PatientLocationWidgetState();
}

class _PatientLocationWidgetState extends State<PatientLocationWidget> {
  Position? _position;
  bool _loading = false;

  bool get isIOS13OrLower {
    if (kIsWeb) return false; // Never block on web
    if (!Platform.isIOS) return false;
    final version = Platform.operatingSystemVersion;
    final match = RegExp(r'(\d+)\.(\d+)').firstMatch(version);
    if (match != null) {
      final major = int.tryParse(match.group(1) ?? '0') ?? 0;
      return major < 14;
    }
    return false;
  }

  Future<void> _getLocation() async {
    setState(() => _loading = true);
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location permission denied')),
      );
      return;
    }
    final pos = await Geolocator.getCurrentPosition();
    setState(() {
      _position = pos;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isIOS13OrLower) {
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: const [
              Icon(Icons.location_on, color: Color(0xFF14366E)),
              SizedBox(height: 8),
              Text(
                'Current Location',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF14366E),
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Location feature requires iOS 14 or higher.',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      );
    }

    // Enable the map and location feature for supported platforms
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.location_on, color: Color(0xFF14366E)),
                const SizedBox(width: 8),
                const Text(
                  'Current Location',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF14366E),
                  ),
                ),
                const Spacer(),
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF14366E),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _loading ? null : _getLocation,
                  child: _loading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : const Text('Detect'),
                ),
              ],
            ),
            if (_position != null) ...[
              const SizedBox(height: 12),
              SizedBox(
                height: 200,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(_position!.latitude, _position!.longitude),
                    zoom: 16,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId('patient'),
                      position: LatLng(
                        _position!.latitude,
                        _position!.longitude,
                      ),
                      infoWindow: const InfoWindow(title: 'Patient Location'),
                    ),
                  },
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Lat: ${_position!.latitude}, Lng: ${_position!.longitude}',
                style: const TextStyle(fontSize: 14, color: Color(0xFF14366E)),
              ),
            ],
            if (_position == null) ...[
              const SizedBox(height: 12),
              const Text(
                'Tap Detect to get your current location.',
                style: TextStyle(color: Color(0xFF14366E)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
