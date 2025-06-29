import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// --- Patient SOS Page ---
class SOSPage extends StatefulWidget {
  const SOSPage({super.key});

  @override
  State<SOSPage> createState() => _SOSPageState();
}

class _SOSPageState extends State<SOSPage> {
  bool _isSending = false;
  String _statusMessage = '';
  String? _caregiverResponse; // 'acknowledged', 'cancelled', or null
  String? _voiceRecordingUrl; // Simulated voice message URL

  void _triggerSOS() async {
    setState(() {
      _isSending = true;
      _statusMessage = 'Sending emergency alert...';
      _caregiverResponse = null;
    });

    // TODO: Integrate with backend, SMS, or call API for real emergency alert.
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isSending = false;
      _statusMessage =
          'Emergency alert sent! Waiting for caregiver response...';
      // Simulate sending a voice recording (optional)
      _voiceRecordingUrl = null; // Set to a URL if a recording is sent
    });

    // Simulate caregiver response after a delay (for demo)
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _caregiverResponse = 'acknowledged'; // or 'cancelled'
        _statusMessage = _caregiverResponse == 'acknowledged'
            ? 'Caregiver has acknowledged your emergency. Help is on the way!'
            : 'Caregiver has cancelled the emergency alert.';
      });
    });
  }

  void _onVoiceHelp() {
    _triggerSOS();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Emergency SOS',
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.warning, color: Colors.red, size: 72),
                const SizedBox(height: 24),
                const Text(
                  'Emergency Assistance',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF14366E),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Press the button below or say "Help" to send an emergency alert to your caregivers.',
                  style: TextStyle(fontSize: 16, color: Color(0xFF14366E)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.sos),
                    label: _isSending
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                              strokeWidth: 2,
                            ),
                          )
                        : const Text('Send SOS'),
                    onPressed: _isSending ? null : _triggerSOS,
                  ),
                ),
                const SizedBox(height: 24),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF14366E),
                    side: const BorderSide(color: Color(0xFF14366E)),
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 24,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.mic),
                  label: const Text('Trigger by Voice ("Help")'),
                  onPressed: _isSending ? null : _onVoiceHelp,
                ),
                const SizedBox(height: 24),
                if (_statusMessage.isNotEmpty)
                  Text(
                    _statusMessage,
                    style: TextStyle(
                      color: _caregiverResponse == 'cancelled'
                          ? Colors.red
                          : _caregiverResponse == 'acknowledged'
                          ? Colors.green
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
