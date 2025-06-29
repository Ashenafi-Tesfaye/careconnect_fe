import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/patient_model.dart';
import 'package:careconnectpt_fe/core/constants/api_constants.dart';


class CaregiverDashboard extends StatefulWidget {
  final int caregiverId;
  const CaregiverDashboard({super.key, this.caregiverId = 1});

  @override
  State<CaregiverDashboard> createState() => _CaregiverDashboardState();
}

class _CaregiverDashboardState extends State<CaregiverDashboard> {
  List<Patient> patients = [];
  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchPatients();
  }

    Future<void> fetchPatients() async {
    setState(() {
      loading = true;
      error = null;
    });
    try {
      final response = await http.get(Uri.parse(
        '${ApiConstants.baseUrl}caregivers/${widget.caregiverId}/patients',
      ));
      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        setState(() {
          patients = data.map((e) => Patient.fromJson(e)).toList();
          loading = false;
        });
      } else {
        setState(() {
          error = 'Failed to load patients';
          loading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error: $e';
        loading = false;
      });
    }
  }

  String formatDate(String dob) {
    try {
      final date = DateTime.parse(dob);
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    } catch (_) {
      return dob;
    }
  }

  @override
  Widget build(BuildContext context) {
    // ... AppBar and Drawer code unchanged ...
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Caregiver Dashboard',
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
          child: loading
              ? const Center(child: CircularProgressIndicator())
              : error != null
                  ? Center(child: Text(error!))
                  : patients.isEmpty
                      ? const Center(child: Text('No patients found.'))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'My Patients',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF14366E),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Expanded(
                              child: ListView.separated(
                                itemCount: patients.length,
                                separatorBuilder: (_, __) => const SizedBox(height: 16),
                                itemBuilder: (context, index) {
                                  final patient = patients[index];
                                  return Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 32,
                                            backgroundImage: const NetworkImage(
                                              'https://randomuser.me/api/portraits/lego/1.jpg',
                                            ),
                                            child: Text(
                                              (patient.firstName.isNotEmpty
                                                      ? patient.firstName[0]
                                                      : 'P')
                                                  .toUpperCase(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${patient.firstName} ${patient.lastName}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    color: Color(0xFF14366E),
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  'DOB: ${formatDate(patient.dob)}',
                                                  style: const TextStyle(fontSize: 15),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  'Phone: ${patient.phone}',
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  'Relationship: ${patient.relationship}',
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Column(
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.list_alt,
                                                  color: Color(0xFF14366E),
                                                ),
                                                tooltip: 'View Logs',
                                                onPressed: () {
                                                  context.go('/patient-logs');
                                                },
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.call,
                                                  color: Color(0xFF14366E),
                                                ),
                                                tooltip: 'Call Patient',
                                                onPressed: () {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Calling ${patient.phone} (simulated)',
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.message,
                                                  color: Color(0xFF14366E),
                                                ),
                                                tooltip: 'Send Message',
                                                onPressed: () {
                                                  context.go('/chatandcalls');
                                                },
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.monitor_heart,
                                                  color: Color(0xFF14366E),
                                                ),
                                                tooltip: 'View Status',
                                                onPressed: () {
                                                  context.go(
                                                    '/patient-status?id=${patient.id}',
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
        ),
      ),
    );
  }
}