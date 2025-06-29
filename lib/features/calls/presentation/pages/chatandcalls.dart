import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatAndCallsPage extends StatefulWidget {
  const ChatAndCallsPage({super.key});

  @override
  State<ChatAndCallsPage> createState() => _ChatAndCallsPageState();
}

class _ChatAndCallsPageState extends State<ChatAndCallsPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      'from': 'caregiver',
      'type': 'text',
      'text': 'Hello! How can I help you today?',
    },
    {
      'from': 'patient',
      'type': 'text',
      'text': 'I have a question about my medication.',
    },
  ];
  bool _isRecording = false;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.add({'from': 'patient', 'type': 'text', 'text': text});
        _messageController.clear();
      });
      // TODO: Send message to backend or caregiver
    }
  }

  void _startVideoCall() {
    // TODO: Integrate with video call SDK
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Starting video call... (feature coming soon)'),
      ),
    );
  }

  void _startAudioCall() {
    // TODO: Integrate with audio call SDK
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Starting audio call... (feature coming soon)'),
      ),
    );
  }

  void _startVoiceRecording() {
    setState(() {
      _isRecording = true;
    });
    // TODO: Start recording using a package like flutter_sound or record
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Voice recording started (simulated)')),
    );
  }

  void _stopVoiceRecording() {
    setState(() {
      _isRecording = false;
      _messages.add({
        'from': 'patient',
        'type': 'voice',
        'text': '[Voice message]',
      });
    });
    // TODO: Stop recording and send the voice message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Voice message sent (simulated)')),
    );
  }

  Widget _buildMessage(Map<String, dynamic> msg) {
    final isPatient = msg['from'] == 'patient';
    final isVoice = msg['type'] == 'voice';
    return Align(
      alignment: isPatient ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isPatient ? const Color(0xFF14366E) : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: isVoice
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.mic,
                    color: isPatient ? Colors.white : const Color(0xFF14366E),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Voice message',
                    style: TextStyle(
                      color: isPatient ? Colors.white : const Color(0xFF14366E),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.play_arrow,
                      color: isPatient ? Colors.white : const Color(0xFF14366E),
                    ),
                    onPressed: () {
                      // TODO: Play voice message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Playing voice message (simulated)'),
                        ),
                      );
                    },
                  ),
                ],
              )
            : Text(
                msg['text'],
                style: TextStyle(
                  color: isPatient ? Colors.white : const Color(0xFF14366E),
                  fontSize: 16,
                ),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat & Calls',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF14366E),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam),
            tooltip: 'Start Video Call',
            onPressed: _startVideoCall,
          ),
          IconButton(
            icon: const Icon(Icons.call),
            tooltip: 'Start Audio Call',
            onPressed: _startAudioCall,
          ),
        ],
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
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) =>
                    _buildMessage(_messages[index]),
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF14366E)),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 0,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF14366E),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: _sendMessage,
                    child: const Icon(Icons.send, size: 20),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onLongPress: _isRecording ? null : _startVoiceRecording,
                    onLongPressUp: _isRecording ? _stopVoiceRecording : null,
                    child: CircleAvatar(
                      backgroundColor: _isRecording
                          ? Colors.red
                          : const Color(0xFF14366E),
                      child: Icon(Icons.mic, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            if (_isRecording)
              const Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Text(
                  'Recording... release to send',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
