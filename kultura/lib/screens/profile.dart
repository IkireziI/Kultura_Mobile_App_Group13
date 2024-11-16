import 'package:flutter/material.dart';
import 'package:kultura/screens/profile_setting.dart';

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
            const AppliBar(),
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
                    GridBar(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(selectedIndex: 4),
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
      backgroundColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Card(
          shape: const CircleBorder(),
          elevation: 5,
          color: Colors.grey,
          child: IconButton(
            icon: const Icon(Icons.settings, size: 30),
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
        children: [
          const SizedBox(width: 100),
          // Profile Picture
          CircleAvatar(
            radius: 60,
            backgroundImage: const AssetImage('assets/pp.jpg'),
          ),
          const SizedBox(width: 60),

          // Profile Stats
          Column(
            children: const [
              StatItem(count: '4', label: 'Posts'),
              SizedBox(height: 10),
              StatItem(count: '783', label: 'Followers'),
              SizedBox(height: 10),
              StatItem(count: '496', label: 'Following'),
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}

// Profile Statistics
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
      padding: const EdgeInsets.all(0),
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
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
          // Username and Artist Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 180),
              const Icon(Icons.person, size: 16, color: Colors.black),
              const SizedBox(width: 5),
              const Text(
                '@Bry_aurel',
                style: TextStyle(color: Colors.black),
              ),
              const Spacer(),
              // Artist Badge
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
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
            'Your Bio goes here',
            style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 10),
          // Edit Profile Button
          Row(
            children: [
              const SizedBox(width: 241),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Edit Profile',
              style: TextStyle(color: Colors.white),
            ),
          ),
            ],
          ),
        ],
      ),
    );
  }
}

// Grid Bar

class GridBar extends StatefulWidget {
  const GridBar({super.key});

  @override
  State<GridBar> createState() => _GridBarState();
}

class _GridBarState extends State<GridBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          indicatorColor: Colors.purple,
          tabs: const [
            Tab(icon: Icon(Icons.grid_on, color: Colors.black)),
            Tab(icon: Icon(Icons.bookmark_border, color: Colors.black)),
          ],
        ),
        SizedBox(
          height: 200,
          child: TabBarView(
            controller: _tabController,
            children: [
              const PostGrid(),
              const Center(
                child: Text('No saved Posts'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Post Grid
class PostGrid extends StatelessWidget {
  const PostGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // List of Posts
    final List<String> images = [
      'assets/post1.jpg',
      'assets/post2.jpeg',
      'assets/post3.jpeg',
      'assets/post4.jpg',
    ];
    
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
        itemCount: images.length,  // Use the number of posts in the List
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(images[index]),
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
        Navigator.pushReplacementNamed(
            context, '/profile'); // Navigates to Profile Screen
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
          icon: Icon(Icons.home_outlined),
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
