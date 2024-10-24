import 'package:flutter/material.dart';

void main() {
  runApp(const ProfileSettingsScreen());
}

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ProfileSettingsPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProfileSettingsPage extends StatelessWidget {
  const ProfileSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Back',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          // Profile Picture and Title
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images(1).jpeg'), 
          ),
          const SizedBox(height: 20),
          const Text(
            'Profile Settings',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          // Menu List Items
          Expanded(
            child: ListView(
              children: const [
                ProfileMenuItem(
                  icon: Icons.person_outline,
                  text: 'Personal Information',
                ),
                ProfileMenuItem(
                  icon: Icons.folder_open,
                  text: 'Create Portfolio',
                ),
                ProfileMenuItem(
                  icon: Icons.settings_outlined,
                  text: 'Settings',
                ),
                ProfileMenuItem(
                  icon: Icons.info_outline,
                  text: 'Account Information',
                ),
                ProfileMenuItem(
                  icon: Icons.notifications_none,
                  text: 'Notifications',
                ),
                ProfileMenuItem(
                  icon: Icons.help_outline,
                  text: 'Help & Support',
                ),
                ProfileMenuItem(
                  icon: Icons.logout,
                  text: 'Logout',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom widget for the list items
class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const ProfileMenuItem({Key? key, required this.icon, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        text,
        style: const TextStyle(fontSize: 18),
      ),
      onTap: () {
        // Handle the onTap action here
      },
    );
  }
}
