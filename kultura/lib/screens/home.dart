import 'package:flutter/material.dart';
import 'package:kultura/screens/marketplace.dart';
import 'package:kultura/screens/search_page.dart';
import 'package:kultura/screens/profile.dart';
import 'package:kultura/screens/opportunities_board.dart';
import 'package:kultura/screens/courses/resource_center.dart';



class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  // Define an array of pages for the bottom navigation bar
  final List<Widget> _pages = [
    const HomePage(), // Home
    const ArtisticCourseScreen(),  // Resource CenterR
    const SearchScreen(),    // Search
    const OpportunitiesBoard(), // Opportunities Board
    const MarketplacePage(),
    const Profile(),   // Profile
  ];

  // Handle navigation bar item tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/kultura.png',
          height: 40,
        ),
        backgroundColor: Colors.purple,
      ),
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 30,
        onTap: _onItemTapped,
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
            icon: Icon(Icons.storefront),
            label: 'Market Place',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Define the Home page with Stories and Posts
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Stories(), // Stories section
        Expanded(child: PostsSection()), // Posts section
      ],
    );
  }
}

// Stories Section
class Stories extends StatelessWidget {
  const Stories({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Stories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // Notification Logic
                    },
                    icon: const Icon(Icons.notifications, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {
                      // Message Logic
                    },
                    icon: const Icon(Icons.message, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                StoryItem(imagePath: 'assets/pp.jpg', label: 'Your Story'),
                StoryItem(imagePath: 'assets/story1.png', label: 'Aurel'),
                StoryItem(imagePath: 'assets/story2.jpg', label: 'Ines'),
                StoryItem(imagePath: 'assets/story3.jpeg', label: 'Liliane'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Story Item
class StoryItem extends StatelessWidget {
  final String imagePath;
  final String label;

  const StoryItem({super.key, required this.imagePath, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(imagePath),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

// Posts Section
class PostsSection extends StatelessWidget {
  const PostsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        PostItem(
          userName: 'Marc_aurel',
          timeAgo: '2 mins ago',
          postText:
              'Join my team for this session we are organizing in collaboration with a painting school.',
          postImage: 'assets/post_home.jpg',
        ),
      ],
    );
  }
}

// Post Item
class PostItem extends StatelessWidget {
  final String userName;
  final String timeAgo;
  final String postText;
  final String postImage;

  const PostItem({
    super.key,
    required this.userName,
    required this.timeAgo,
    required this.postText,
    required this.postImage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/marc.jpg'),
            ),
            title: Text(userName),
            subtitle: Text(timeAgo),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(postText),
          ),
          Image.asset(postImage, fit: BoxFit.cover),
        ],
      ),
    );
  }
}

