import 'package:flutter/material.dart';
import 'package:kultura/pages/profile_setting.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xBF9E06C4),
              Color(0x809E06C5),
              Color(0x669E06C5),
              Color(0x339E06C4),
              Color(0x269E06C4),
              Color(0x1A9E06C4),
            ],
          ),
        ),
        child: Column(
          children: [
            // App Bar with the Settings Icon and the Title
            AppliBar(),

            const SizedBox(height: 5),
            // Profile Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: const [
                    SizedBox(height: 20),
                    // Profile Picture, Username, Bio and Location
                    ProfileHeader(),

                    SizedBox(height: 10),
                    // Profile Infos
                    ProfileInfos(),

                    SizedBox(height: 10),
                    // Post Grid
                    PostGrid(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(selectedIndex: 4),
    );
  }
}

// AppBar Class
class AppliBar extends StatelessWidget {
  const AppliBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent, // To display the general background color
      leading: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Card(
          shape: CircleBorder(),
          elevation: 5,
          color: Colors.grey,
          child: IconButton(
            icon: Icon(Icons.settings, size: 30),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileSettingsScreen(),
                ),
              );
            },
          ),
        ),      
      ),
      title: Image.asset(
        'assets/kultura.png',
        height: 40,
      ),
    );
  }
}

// Profile Header Class
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 120),
          // Profile Pic
          Container(
            width: 120,
            height: 138,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(120),
              image: const DecorationImage(
                image: AssetImage('assets/pp.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 30),
          
          // Profile Statistics (Posts, Followers, Following)
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const ProfileStats(),
              const SizedBox(height: 8),
            ],
          ),
        ],
      ), 
    );
  }
}

// Profile Statistics
class ProfileStats extends StatelessWidget {
  const ProfileStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatItem(count: '4', label: 'Posts'),
        const SizedBox(height: 10),
        StatItem(count: '783', label: 'Followers'),
        const SizedBox(height: 10),
        StatItem(count: '496', label: 'Following'),
      ],
    );
  }
}

class StatItem extends StatelessWidget {
  final String count;
  final String label;
  const StatItem({super.key, required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            count,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

// Profile Infos (Username, Bio, Artist, etc...)
class ProfileInfos extends StatelessWidget {
  const ProfileInfos({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
          children: [
          // Username
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 150, height: 0),
              const Icon(Icons.person, size: 16, color: Colors.black),
              const SizedBox(width: 5),
              const Text(
                '@Bry_aurel',
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(width: 100),
              // Artist Badge
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Artist',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),

          // Location
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.location_on, size: 16, color: Colors.black),
              SizedBox(width: 5),
              Text(
                'Kigali, Rwanda',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          const SizedBox(height: 5),

          // Bio
          const Text(
            'Your bio goes here',
            style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 10),

          // Artist Badge and Edit Profile Button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 280),
              // Edit Profile Button
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                ),
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Post Grid
class PostGrid extends StatelessWidget {
  const PostGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 1,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/post1.jpg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          );
        },
      ),
    );
  }
}

// Bottom navigation bar widget with 5 items
class BottomNavigation extends StatefulWidget {
  final int selectedIndex; // Tracks the currently selected tab

  const BottomNavigation({super.key, required this.selectedIndex});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex; // Sets the initial selected tab
  }

  // Handles tap events for each navigation item
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home'); // Navigates to Home
        break;
      case 1:
        Navigator.pushReplacementNamed(
            context, '/resource_center'); // Navigates to Resource Center
        break;
      case 2:
        Navigator.pushReplacementNamed(
            context, '/search'); // Navigates to Search Screen
        break;
      case 3:
        Navigator.pushReplacementNamed(context,
            '/opportunities_board'); // Navigates to Opportunities board
        break;
      case 4:
        Navigator.pushReplacementNamed(context,
            '/profile_settings'); // Navigates directly to ProfileSettingsScreen
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex, // Highlights the selected tab
      type: BottomNavigationBarType.fixed, // Fixed tab type
      selectedItemColor: Colors.purple, // Selected icon color
      unselectedItemColor: Colors.grey, // Unselected icon color
      showSelectedLabels: false, // Hides selected labels
      showUnselectedLabels: false, // Hides unselected labels
      iconSize: 30, // Sets icon size
      onTap: _onItemTapped, // Triggers _onItemTapped on tap
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.add_home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.auto_stories_outlined),
          label: 'Resource Center',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.language_outlined),
          label: 'Opportunities Board',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined),
          label: 'Profile',
        ),
      ],
    );
  }
}
