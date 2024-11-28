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
          const _StoriesSection(),
          // Posts Section
          Expanded(
            child: _PostsSection(),
          ),
        ],
      ),
      floatingActionButton: const _AddPostButton(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          // Navigation logic if needed
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Explore"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

// Stories Section
class _StoriesSection extends StatelessWidget {
  const _StoriesSection();

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
                  _ActionIcon(
                    icon: Icons.notifications,
                    onPressed: () {
                      // Notification logic
                    },
                  ),
                  const SizedBox(width: 10),
                  _ActionIcon(
                    icon: Icons.message,
                    onPressed: () {
                      // Messages logic
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 151,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.purple,
          ),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              _StoryItem(imagePath: 'assets/pp.jpg', label: 'Your Story'),
              _StoryItem(imagePath: 'assets/story1.png', label: 'Aurel'),
              _StoryItem(imagePath: 'assets/story2.jpg', label: 'Ines'),
              _StoryItem(imagePath: 'assets/story3.jpeg', label: 'Liliane'),
            ],
          ),
        ),
      ],
    );
  }
}

// Action Icon for Stories Section
class _ActionIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _ActionIcon({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      color: Colors.white,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.black),
      ),
    );
  }
}

// Story Item
class _StoryItem extends StatelessWidget {
  final String imagePath;
  final String label;

  const _StoryItem({required this.imagePath, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
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
    );
  }
}

// Posts Section
class _PostsSection extends StatelessWidget {
  const _PostsSection();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        _PostItem(
          userName: 'Marc_aurel',
          timeAgo: '2 mins ago',
          postText:
              'Join my Team and I for this session we are organizing in Collaboration with a painting school.',
          postImage: 'assets/post_home.jpg',
        ),
      ],
    );
  }
}

// Post Item
class _PostItem extends StatelessWidget {
  final String userName;
  final String timeAgo;
  final String postText;
  final String postImage;

  const _PostItem({
    required this.userName,
    required this.timeAgo,
    required this.postText,
    required this.postImage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
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
              onPressed: () {
                // Follow logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
              ),
              child: const Text('Follow'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(postText),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
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
class _AddPostButton extends StatefulWidget {
  const _AddPostButton();

  @override
  State<_AddPostButton> createState() => __AddPostButtonState();
}

class __AddPostButtonState extends State<_AddPostButton> {
  bool _isChipsVisible = false;

  void _toggleChipsVisibility() {
    setState(() {
      _isChipsVisible = !_isChipsVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _toggleChipsVisibility,
      backgroundColor: Colors.purple,
      child: const Icon(Icons.add, size: 50),
    );
  }
}
