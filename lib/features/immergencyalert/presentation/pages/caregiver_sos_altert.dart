import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// --- Caregiver Emergency Alert View ---
class CaregiverSOSAlertPage extends StatefulWidget {
  final String? voiceRecordingUrl; // If a voice message is sent

  const CaregiverSOSAlertPage({super.key, this.voiceRecordingUrl});

  @override
  State<CaregiverSOSAlertPage> createState() => _CaregiverSOSAlertPageState();
}

class _CaregiverSOSAlertPageState extends State<CaregiverSOSAlertPage> {
  String? _response; // 'acknowledged' or 'cancelled'

  void _acknowledge() {
    setState(() {
      _response = 'acknowledged';
    });
    // TODO: Notify backend/patient of acknowledgment
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('You have acknowledged the emergency.')),
    );
  }

  void _cancel() {
    setState(() {
      _response = 'cancelled';
    });
    // TODO: Notify backend/patient of cancellation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('You have cancelled the emergency alert.')),
    );
  }

  void _playVoiceRecording() {
    // TODO: Implement audio playback
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Playing voice recording (simulated).')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Patient Emergency Alert',
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
                'Caregiver Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
                context.go('/dashboard/caregiver');
              },
            ),
            ListTile(
              leading: const Icon(Icons.list_alt),
              title: const Text('Patient Logs'),
              onTap: () {
                Navigator.pop(context);
                context.go('/patient-logs');
              },
            ),
            ListTile(
              leading: const Icon(Icons.monitor_heart),
              title: const Text('Patient Status'),
              onTap: () {
                Navigator.pop(context);
                context.go('/patient-status');
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
              leading: const Icon(Icons.warning),
              title: const Text('Emergency Alerts'),
              onTap: () {
                Navigator.pop(context);
                context.go('/caregiver-sos-alert');
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
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.warning, color: Colors.red, size: 72),
              const SizedBox(height: 24),
              const Text(
                'Patient Emergency Alert',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF14366E),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'A patient has triggered an emergency alert. Please respond below.',
                style: TextStyle(fontSize: 16, color: Color(0xFF14366E)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              if (widget.voiceRecordingUrl != null)
                OutlinedButton.icon(
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Listen to Voice Recording'),
                  onPressed: _playVoiceRecording,
                ),
              if (_response == null) ...[
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.green,
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
                    icon: const Icon(Icons.check),
                    label: const Text('Acknowledge'),
                    onPressed: _acknowledge,
                  ),
                ),
                const SizedBox(height: 16),
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
                    icon: const Icon(Icons.cancel),
                    label: const Text('Cancel Alert'),
                    onPressed: _cancel,
                  ),
                ),
              ] else ...[
                const SizedBox(height: 24),
                Text(
                  _response == 'acknowledged'
                      ? 'You have acknowledged the emergency. Please assist the patient.'
                      : 'You have cancelled the emergency alert.',
                  style: TextStyle(
                    color: _response == 'acknowledged'
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
