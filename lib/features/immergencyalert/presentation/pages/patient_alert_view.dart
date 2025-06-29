import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Suppressed for iOS 13 and below
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';

class PatientAlertViewPage extends StatelessWidget {
  final double latitude;
  final double longitude;
  final String patientPhone;

  const PatientAlertViewPage({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.patientPhone,
  });

  bool get isIOS13OrLower {
    if (!Platform.isIOS) return false;
    final version = Platform.operatingSystemVersion;
    final match = RegExp(r'(\d+)\.(\d+)').firstMatch(version);
    if (match != null) {
      final major = int.tryParse(match.group(1) ?? '0') ?? 0;
      return major < 14;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Patient Alert',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF14366E),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF14366E)),
              child: const Text(
                'Patient Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
                context.go('/dashboard/patient');
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Task Scheduling'),
              onTap: () {
                Navigator.pop(context);
                context.go('/taskscheduling');
              },
            ),
            ListTile(
              leading: const Icon(Icons.chat),
              title: const Text('Chat & Calls'),
              onTap: () {
                Navigator.pop(context);
                context.go('/chatandcalls');
              },
            ),
            ListTile(
              leading: const Icon(Icons.smart_toy),
              title: const Text('AI Assistant'),
              onTap: () {
                Navigator.pop(context);
                context.go('/aiassistant');
              },
            ),
            ListTile(
              leading: const Icon(Icons.watch),
              title: const Text('Fitbit Integration'),
              onTap: () {
                Navigator.pop(context);
                context.go('/fitbit');
              },
            ),
            ListTile(
              leading: const Icon(Icons.warning),
              title: const Text('Emergency SOS'),
              onTap: () {
                Navigator.pop(context);
                context.go('/sos');
              },
            ),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Subscribe'),
              onTap: () {
                Navigator.pop(context);
                context.go('/select-package');
              },
            ),
            ListTile(
              leading: const Icon(Icons.emoji_events),
              title: const Text('Achievements'),
              onTap: () {
                Navigator.pop(context);
                context.go('/gamification');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // Add logout logic if needed
                Navigator.pop(context);
                context.go('/');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              'Patient Location',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xFF14366E),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 250,
              child: isIOS13OrLower
                  ? const Center(
                      child: Text(
                        'Map feature requires iOS 14 or higher.',
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  : const Placeholder(
                      fallbackHeight: 250,
                      color: Color(0xFF14366E),
                      strokeWidth: 2,
                    ),
              // To re-enable, uncomment and use GoogleMap:
              // child: GoogleMap(
              //   initialCameraPosition: CameraPosition(
              //     target: LatLng(latitude, longitude),
              //     zoom: 16,
              //   ),
              //   markers: {
              //     Marker(
              //       markerId: const MarkerId('patient'),
              //       position: LatLng(latitude, longitude),
              //       infoWindow: const InfoWindow(title: 'Patient Location'),
              //     ),
              //   },
              //   zoomControlsEnabled: false,
              // ),
            ),
            SizedBox(
              height: 250,
              child: isIOS13OrLower
                  ? const Center(
                      child: Text(
                        'Map feature requires iOS 14 or higher.',
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  : GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(latitude, longitude),
                        zoom: 16,
                      ),
                      markers: {
                        Marker(
                          markerId: const MarkerId('patient'),
                          position: LatLng(latitude, longitude),
                          infoWindow: const InfoWindow(
                            title: 'Patient Location',
                          ),
                        ),
                      },
                      zoomControlsEnabled: false,
                    ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              icon: const Icon(Icons.dashboard, color: Color(0xFF14366E)),
              label: const Text('View Patient Dashboard'),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF14366E),
                side: const BorderSide(color: Color(0xFF14366E)),
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 24,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                context.go('/dashboard/patient');
              },
            ),
          ],
        ),
      ),
    );
  }
}
