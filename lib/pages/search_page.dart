import 'package:flutter/material.dart';

void main() {
  runApp(const SearchScreen());
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: KulturaHomePage(),
    );
  }
}

class KulturaHomePage extends StatelessWidget {
  // List of images for "Profiles suggested for you"
  final List<String> profileImages = [
    'assets/person1.jpeg',
    'assets/person2.jpeg',
    'assets/person3.jpeg',
    'assets/person4.jpeg',
  ];

  // Lists for images and background images for the Explore section
  final List<String> exploreImages = [
    'assets/person1.jpeg',
    'assets/person2.jpeg',
    'assets/person3.jpeg',
    'assets/person4.jpeg',
    'assets/person5.jpeg',
    'assets/person6.jpeg',
    'assets/person7.jpeg',
    'assets/person8.jpeg',
    'assets/person9.jpeg',
  ];

  final List<String> exploreBackgrounds = [
    'assets/person5.jpeg',
    'assets/people2.jpeg',
    'assets/people3.jpeg',
    'assets/people4.jpeg',
    'assets/people5.jpeg',
    'assets/people6.jpeg',
    'assets/people7.jpeg',
    'assets/people8.jpeg',
    'assets/people9.jpeg',
  ];

  KulturaHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [
              Color(0xFFA020F0), // Purple color at the top
              Colors.white, // White background at the bottom
            ],
            stops: [0.3, 1.0],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Section with KULTURA
            Padding(
              padding: const EdgeInsets.only(top: 50.0, bottom: 10.0),
              child: Center(
                child: Image.asset(
                  'assets/kultura.png',
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      fontFamily: 'Roboto',
                    ),
                    border: InputBorder.none,
                    icon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.filter_list),
                  ),
                ),
              ),
            ),
            // Profiles Suggested for You
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 5.0, bottom: 5.0),
              child: const Text(
                'Profiles suggested for you',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            SizedBox(
              height: 130,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: profileImages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              const Spacer(),
                              CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    AssetImage(profileImages[index]),
                              ),
                              const Spacer(),
                              Container(
                                width: 90,
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  'Username ${index + 1}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Explore Section
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: const Text(
                'Explore',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 0),
                padding: const EdgeInsets.all(0),
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: exploreImages.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        // Grid background image
                        Positioned.fill(
                          child: Image.asset(
                            exploreBackgrounds[
                                index % exploreBackgrounds.length],
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Username and profile picture on top-left
                        Positioned(
                          top: 5,
                          left: 5,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 15,
                                backgroundImage:
                                    AssetImage(exploreImages[index]),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Username ${index + 1}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(selectedIndex: 2,),
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

