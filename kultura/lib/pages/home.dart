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
        floatingActionButton: const AddPost(),
        // Body
        bottomNavigationBar: BottomNavigation(selectedIndex: 0,),
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
                  Color.fromARGB(255, 184, 70, 204),
                  Color.fromARGB(255, 166, 66, 184),
                  Color.fromARGB(255, 234, 153, 248),
                  Color.fromARGB(255, 235, 150, 250),
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
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                    color: Colors.white,
                    child: IconButton(
                      onPressed: () {
                        // Notification Logic
                      },
                      icon: const Icon(Icons.notifications, color: Colors.black),
                    ),
                  ),
                  SizedBox(width: 10),

                  // Messages Card
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                    color: Colors.white,
                    child: IconButton(
                      onPressed: () {
                        // Message Logic
                      },
                      icon: const Icon(Icons.message, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      
        // Stories Section
        Container(
          height: 151,
          padding: const EdgeInsets.symmetric(vertical: 10,),
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
                style: const TextStyle(color: Colors.black, fontSize: 12),
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
          Container(
            padding: EdgeInsets.all(8.0),
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(postImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Add Post Button
class AddPost extends StatefulWidget{
  const AddPost({super.key});

@override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  bool _isChipsVisible = false;

  void _toggleChipsVisibility(){
    setState(() {
      _isChipsVisible = !_isChipsVisible;
    });
  }
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _toggleChipsVisibility,
      backgroundColor: Colors.purple,
      elevation: 5,
      child: const Icon(Icons.add, size: 50, color: Colors.black),
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
