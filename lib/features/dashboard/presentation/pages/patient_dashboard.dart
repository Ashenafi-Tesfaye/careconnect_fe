import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PatientDashboard extends StatelessWidget {
  const PatientDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Patient Dashboard',
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome, Patient!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF14366E),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.calendar_today,
                    color: Color(0xFF14366E),
                  ),
                  title: const Text('Upcoming Appointments'),
                  subtitle: const Text('You have 2 appointments this week'),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFF14366E),
                    ),
                    onPressed: () {
                      context.go('/appointments');
                    },
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.medical_services,
                    color: Color(0xFF14366E),
                  ),
                  title: const Text('My Care Team'),
                  subtitle: const Text('View your caregivers and doctors'),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFF14366E),
                    ),
                    onPressed: () {
                      context.go('/careteam');
                    },
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.notifications,
                    color: Color(0xFF14366E),
                  ),
                  title: const Text('Notifications'),
                  subtitle: const Text('No new notifications'),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFF14366E),
                    ),
                    onPressed: () {
                      context.go('/notifications');
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF14366E),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    context.go('/profile');
                  },
                  child: const Text('View Profile'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
