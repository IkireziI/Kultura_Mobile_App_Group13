import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsPage();
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/kultura_logo.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.manage_accounts, color: Colors.grey),
            title: const Text('Manage Account', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Handle tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock, color: Colors.grey),
            title:
                const Text('Change Password', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Handle tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.help, color: Colors.grey),
            title: const Text('Help & Support', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Handle tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.security, color: Colors.grey),
            title: const Text('Privacy and security',
                style: TextStyle(fontSize: 18)),
            onTap: () {
              // Handle tap
            },
          ),
        ],
      ),
    );
  }
}
