import 'package:flutter/material.dart';
import 'package:kultura/pages/opportunities_board.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MarketplaceMusicPage(),
    );
  }
}

class SearchBarAndFilters extends StatelessWidget {
  const SearchBarAndFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Search bar for searching opportunities
          TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: Icon(Icons.search_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
          const SizedBox(height: 16), // Space between search bar and filters
          // Filter chips (Music, Painting, Literature)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              CustomFilterChip(label: 'Music', isSelected: true),
              CustomFilterChip(label: 'Painting', isSelected: false),
              CustomFilterChip(label: 'Literature', isSelected: false),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const CustomFilterChip({
    required this.label,
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (bool selected) {
        // Handle filter selection logic
      },
      selectedColor: Colors.purple,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
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
            '/market_music'); // Navigates to Marketplace Music
        break;
      case 4:
        Navigator.pushReplacementNamed(context,
            '/opportunities_board'); // Navigates to Opportunities board
        break;
      case 5:
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
          icon: Icon(Icons.music_note),
          label: 'Music Marketplace',
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

class MarketplaceMusicPage extends StatelessWidget {
  MarketplaceMusicPage({super.key}); // Add 'const' to make it a constant constructor

  final items = [
    {
      "image": "https://example.com/music1.jpg",
      "price": "30000 RWF"
    },
    {
      "image": "https://example.com/music2.jpg",
      "price": "50000 RWF"
    },
    {
      "image": "https://example.com/music3.jpg",
      "price": "70000 RWF"
    },
    {
      "image": "https://example.com/music4.jpg",
      "price": "100000 RWF"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'KULTURA',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.purpleAccent,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subtitle
            Text(
              'Music Marketplace',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.purple[100],
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Music Opportunities',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
            SizedBox(height: 10),

            // Filter Chips
            Row(
              children: [
                FilterChip(
                  label: Text('Music'),
                  onSelected: (value) {},
                  backgroundColor: Colors.purple[300],
                  selected: true,
                ),
                SizedBox(width: 8),
                FilterChip(
                  label: Text('Painting'),
                  onSelected: (value) {},
                  backgroundColor: Colors.purple[100],
                ),
                SizedBox(width: 8),
                FilterChip(
                  label: Text('Literature'),
                  onSelected: (value) {},
                  backgroundColor: Colors.purple[100],
                ),
              ],
            ),
            SizedBox(height: 10),

            // Location
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.grey),
                Text(
                  'Kigali, Rwanda',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Grid of items
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: items.length, // Number of items in grid
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Handle onTap for each item
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(
                                  items[index]['image']!,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          items[index]['price']!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(selectedIndex: 3),
    );
  }
}
