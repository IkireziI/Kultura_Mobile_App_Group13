import 'package:flutter/material.dart';
import 'package:kultura/screens/settings.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileSettingsPage();
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
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/girl.png'),
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
          Expanded(
            child: ListView(
              children: [
                const ProfileMenuItem(
                  icon: Icons.person_outline,
                  text: 'Personal Information',
                ),
                const ProfileMenuItem(
                  icon: Icons.folder_open,
                  text: 'Create Portfolio',
                ),
                ProfileMenuItem(
                  icon: Icons.settings_outlined,
                  text: 'Settings',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsScreen()),
                    );
                  },
                ),
                const ProfileMenuItem(
                  icon: Icons.info_outline,
                  text: 'Account Information',
                ),
                const ProfileMenuItem(
                  icon: Icons.notifications_none,
                  text: 'Notifications',
                ),
                const ProfileMenuItem(
                  icon: Icons.help_outline,
                  text: 'Help & Support',
                ),
                const ProfileMenuItem(
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

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        text,
        style: const TextStyle(fontSize: 18),
      ),
      onTap: onTap,
    );
  }
}
