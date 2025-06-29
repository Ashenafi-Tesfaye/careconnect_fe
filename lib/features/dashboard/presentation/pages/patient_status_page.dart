import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:go_router/go_router.dart';

class PatientStatusPage extends StatelessWidget {
  final String name;
  final int age;
  final String photo;
  final String condition;
  final double latitude;
  final double longitude;

  const PatientStatusPage({
    super.key,
    this.name = 'John Doe',
    this.age = 72,
    this.photo = 'https://randomuser.me/api/portraits/men/32.jpg',
    this.condition = 'Stable',
    this.latitude = 37.7749,
    this.longitude = -122.4194,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Patient Status',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(radius: 32, backgroundImage: NetworkImage(photo)),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFF14366E),
                      ),
                    ),
                    Text('Age: $age'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Current Condition',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF14366E),
              ),
            ),
            const SizedBox(height: 8),
            Text(condition, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),
            const Text(
              'Current Location',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF14366E),
              ),
            ),
            const SizedBox(height: 8),
            // SizedBox(
            //   height: 200,
            //   child: GoogleMap(
            //     initialCameraPosition: CameraPosition(
            //       target: LatLng(latitude, longitude),
            //       zoom: 16,
            //     ),
            //     markers: {
            //       Marker(
            //         markerId: const MarkerId('patient'),
            //         position: LatLng(latitude, longitude),
            //         infoWindow: const InfoWindow(title: 'Patient Location'),
            //       ),
            //     },
            //     zoomControlsEnabled: false,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
