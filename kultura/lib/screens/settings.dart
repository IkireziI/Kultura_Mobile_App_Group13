import 'package:flutter/material.dart';
import 'package:kultura/screens/add_work.dart';
import 'package:kultura/screens/changePassword.dart';
import 'package:kultura/screens/view_portfolios.dart';

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
        title: const Text(
          'Back',
          style: TextStyle(color: Colors.black),
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
            leading: const Icon(Icons.folder_open, color: Colors.grey),
            title: const Text('View portfolios', style: TextStyle(fontSize: 18)),
            onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewPortfoliosPage()),
                    );
                  },
          ),
          ListTile(
            leading: const Icon(Icons.lock, color: Colors.grey),
            title:
                const Text('Change Password', style: TextStyle(fontSize: 18)),
            onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePasswordScreen()),
                    );
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
            title: const Text('Add Art',
                style: TextStyle(fontSize: 18)),
            onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddArtworkPage()),
                    );
                  },
          ),
        ],
      ),
    );
  }
}
