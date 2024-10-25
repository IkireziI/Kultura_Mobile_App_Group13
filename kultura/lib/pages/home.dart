import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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

        body: Column(
          children: [
            // Stories Section
            const Stories(),
            // HomePage
            Expanded(
              child: HomePageContent()
            ),
          ],
        ),
        // Body
        bottomNavigationBar: BottomNavigation(),
        // Bottom Navigation Bar
    );
  }
}

// HomePage Content
class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.purple,
                  Color.fromARGB(255, 172, 48, 194),
                  Color.fromARGB(255, 202, 62, 226),
                  Color.fromARGB(255, 217, 100, 238),
                  Color.fromARGB(255, 212, 131, 226),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Recent Posts',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: PostsSection(),
                ),
              ],
            ),
          ), 
        ),
      ],
    );
  }
}

// Stories Section
class Stories extends StatelessWidget {
  const Stories({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.purple,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Stories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              // Notifications and Messages Icons
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
        ),
      
        // Stories Section
        Container(
          height: 120,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.purple,
          ),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              StoryItem(imagePath: 'assets/pp.jpg', label: 'Your Story'),
              StoryItem(imagePath: 'assets/story1.png', label: 'Aurel'),
              StoryItem(imagePath: 'assets/story2.jpg', label: 'Ines'),
              StoryItem(imagePath: 'assets/story3.jpeg', label: 'Liliane'),
            ],
          ),
        ),
      ],
    );

    
  }
}

// Story Items
class StoryItem extends StatelessWidget {
  final String imagePath;
  final String label;

  const StoryItem({super.key, required this.imagePath, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color.fromARGB(255, 65, 108, 226), width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(imagePath),
              ),
              const SizedBox(height: 10),
              Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Post Section
class PostsSection extends StatelessWidget {
  const PostsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        PostItem(
          userName: 'Marc_aurel',
          timeAgo: '2 mins ago',
          postText: 'Join my Team and I for this session we are organizing in Collaboration with a painting school.',
          postImage: 'assets/post_home.jpg',
        ),
      ],
    );
  }
}

// Post Item Class
class PostItem extends StatelessWidget {
  final String userName;
  final String timeAgo;
  final String postText;
  final String postImage;

  const PostItem({super.key, required this.userName, required this.timeAgo, required this.postText, required this.postImage});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/marc.jpg'),
            ),
            title: Text(userName),
            subtitle: Text(timeAgo),
            trailing: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
              ),
              child: Text(
                'Follow',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(postText),
          ),
          Image.asset(postImage),
        ],
      ),
    );
  }
}

// Bottom Navigation bar widget
class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.purple,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
        // Add your navigation logic here
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.add_home_outlined), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.auto_stories_outlined), label: 'Resources'),
        BottomNavigationBarItem(icon: Icon(Icons.search_outlined), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.language_outlined), label: 'Opportunities'),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: 'Profile'),
      ],
    );
  }
}

