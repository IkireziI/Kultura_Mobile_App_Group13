import 'package:flutter/material.dart';

void main() {
  runApp(const SettingsScreen());
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SettingsPage(),
      debugShowCheckedModeBanner: false,
    );
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
          // Header with image and title
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
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                
                  SizedBox(height: 10), // Space between image and title
                   
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Settings options
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
