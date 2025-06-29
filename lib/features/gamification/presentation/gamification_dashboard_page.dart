import 'package:flutter/material.dart';
import '../models/achievement_model.dart';
import 'package:go_router/go_router.dart';

class GamificationDashboardPage extends StatelessWidget {
  const GamificationDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final achievements = [
      AchievementModel(
        title: 'First Login',
        description: 'Logged in for the first time',
        unlocked: true,
      ),
      AchievementModel(
        title: 'Scheduled a Task',
        description: 'Scheduled your first care task',
        unlocked: false,
      ),
      AchievementModel(
        title: 'Completed a Task',
        description: 'Marked a task as complete',
        unlocked: false,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Achievements',
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
      body: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: achievements.length,
        itemBuilder: (context, index) {
          final ach = achievements[index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Icon(
                ach.unlocked ? Icons.emoji_events : Icons.lock,
                color: ach.unlocked ? Colors.amber : Colors.grey,
                size: 32,
              ),
              title: Text(
                ach.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(ach.description),
              trailing: ach.unlocked
                  ? const Text(
                      'Unlocked',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const Text('Locked', style: TextStyle(color: Colors.red)),
            ),
          );
        },
      ),
    );
  }
}
