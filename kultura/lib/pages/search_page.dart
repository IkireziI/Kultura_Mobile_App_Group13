import 'package:flutter/material.dart';

void main() {
  runApp(KulturaApp());
}

class KulturaApp extends StatelessWidget {
  const KulturaApp({super.key});

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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [
              Color(0xFFA020F0), // Purple color at the top
              Colors.white,       // White background at the bottom
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
                child: Center(
                  child: Image.asset(
                    'assets/kultura.png',
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
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
              child: Text(
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
                              Spacer(),
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: AssetImage(profileImages[index]),
                              ),
                              Spacer(),
                              Container(
                                width: 90,
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  'Username ${index + 1}',
                                  style: TextStyle(
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
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Text(
                'Explore',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 0),
                padding: EdgeInsets.all(0),
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                            exploreBackgrounds[index % exploreBackgrounds.length],
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
                                backgroundImage: AssetImage(exploreImages[index]),
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Username ${index + 1}',
                                style: TextStyle(
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
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.purpleAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: 2,
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
            label: 'Marketplace',
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
