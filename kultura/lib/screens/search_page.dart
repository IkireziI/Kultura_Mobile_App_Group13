import 'package:flutter/material.dart';
import 'package:kultura/screens/home.dart';
import 'package:kultura/screens/courses/literature_course.dart';
import 'package:kultura/screens/courses/music_course.dart';
import 'package:kultura/screens/opportunities_board.dart' as opportunities;
import 'package:kultura/screens/courses/painting_course.dart';
import 'package:kultura/screens/profile.dart';
import 'package:kultura/screens/profile_setting.dart';
import 'package:kultura/screens/courses/resource_center.dart' as resources;

void main() {
  runApp(const KulturaApp());
}

class KulturaApp extends StatelessWidget {
  const KulturaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kultura App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const Home(),
        '/resource_center': (context) => const resources.ArtisticCourseScreen(),
        '/music': (context) => const MusicCourseScreen(),
        '/painting': (context) => const PaintingCourseScreen(),
        '/literature': (context) => const LiteratureCourseScreen(),
        '/opportunities_board': (context) =>
            const opportunities.OpportunitiesBoard(),
        '/profile': (context) => const Profile(),
        '/profile_setting': (context) => const ProfileSettingsScreen(),
        '/search': (context) => const SearchScreen(),
      },
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KulturaHomePage(),
      bottomNavigationBar: const BottomNavigation(selectedIndex: 2),
    );
  }
}

class KulturaHomePage extends StatelessWidget {
  final List<String> profileImages = [
    'assets/person1.jpeg',
    'assets/person2.jpeg',
    'assets/person3.jpeg',
    'assets/person4.jpeg',
  ];

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
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.center,
          colors: [
            Color(0xFF9C27B0),
            Color(0xFFE1BEE7),
          ],
          stops: [0.3, 1.0],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                              backgroundImage: AssetImage(profileImages[index]),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
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
                      Positioned.fill(
                        child: Image.asset(
                          exploreBackgrounds[index % exploreBackgrounds.length],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 5,
                        left: 5,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundImage: AssetImage(exploreImages[index]),
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
    );
  }
}

class BottomNavigation extends StatefulWidget {
  final int selectedIndex;

  const BottomNavigation({super.key, required this.selectedIndex});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/resource_center');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/search');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/opportunities_board');
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
          icon: Icon(Icons.account_circle_outlined),
          label: 'Profile',
        ),
      ],
    );
  }
}
