import 'package:flutter/material.dart';

class OpportunitiesBoard extends StatelessWidget {
  const OpportunitiesBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: SizedBox(
          width: double.infinity,
          child: Center(
            child: Image.asset(
              'assets/images/KULTURA.png',
              height: 40,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          const OpportunitiesBoardContent(),
          Positioned(
            bottom: 30.0,
            left: 16.0, // Added padding for better positioning
            right: 16.0, // Added padding for better positioning
            child: Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/marketplace');
                },
                icon: const Icon(Icons.local_offer_outlined, color: Colors.black),
                label: const Text(
                  'Marketplace',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigation(
        selectedIndex: 3,
      ),
    );
  }
}

class OpportunitiesBoardContent extends StatelessWidget {
  const OpportunitiesBoardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SearchBarAndFilters(),
        Expanded(
          child: const OpportunitiesList(),
        ),
      ],
    );
  }
}

class SearchBarAndFilters extends StatefulWidget {
  const SearchBarAndFilters({super.key});

  @override
  State<SearchBarAndFilters> createState() => _SearchBarAndFiltersState();
}

class _SearchBarAndFiltersState extends State<SearchBarAndFilters> {
  bool _isFilterVisible = false;
  String selectedCategory = 'Music';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search Opportunities',
              prefixIcon: const Icon(Icons.search_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              filled: true,
              fillColor: Colors.purple[200],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              // Filter icon on the left
              IconButton(
                onPressed: () {
                  setState(() {
                    _isFilterVisible = !_isFilterVisible;
                  });
                },
                icon: Icon(
                  _isFilterVisible ? Icons.close : Icons.filter_list,
                  color: Colors.black,
                ),
              ),

              // Centered categories
              Expanded(
                child: Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8.0,
                    children:
                        ['Music', 'Painting', 'Literature'].map((category) {
                      return FilterChip(
                        label: Text(category),
                        selected: selectedCategory == category,
                        onSelected: (bool selected) {
                          setState(() {
                            selectedCategory = selected ? category : '';
                          });
                        },
                        backgroundColor: Colors.purple[100],
                        selectedColor: Colors.purple,
                        labelStyle: TextStyle(
                          color: selectedCategory == category
                              ? Colors.white
                              : Colors.black,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side:
                              const BorderSide(color: Colors.purple, width: 1),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              // Empty SizedBox to balance the layout
              const SizedBox(width: 48), // Width matches IconButton
            ],
          ),
          if (_isFilterVisible)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  // Add your additional filters here
                ],
              ),
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
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (bool selected) {
        // Logic to handle selection
      },
      backgroundColor: Colors.purple[100],
      selectedColor: Colors.purple,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30), // Rounded rectangular shape
        side: BorderSide(color: Colors.purple, width: 1), // Border color and width
      ),
    );
  }
}


class OpportunitiesList extends StatelessWidget {
  const OpportunitiesList({super.key});

  @override
  Widget build(BuildContext context) {
    final opportunities = [
      {
        'title': 'Music Teacher',
        'category': 'Job',
        'location': 'Kigali',
        'description': 'Looking for a music teacher to teach guitar and piano to students.',
      },
      {
        'title': 'Rock Band Audition',
        'category': 'Audition',
        'location': 'Nigeria',
        'description': 'We are holding auditions for a Rock Band in the city.',
      },
      {
        'title': 'Choral Singing Contest',
        'category': 'Contest',
        'location': 'India',
        'description': 'Join the International Singing Competition for a chance to win \$15,000.',
      },
    ];

    return ListView.builder(
      itemCount: opportunities.length,
      itemBuilder: (context, index) {
        return OpportunityCard(
          title: opportunities[index]['title']!,
          category: opportunities[index]['category']!,
          location: opportunities[index]['location']!,
          description: opportunities[index]['description']!,
        );
      },
    );
  }
}

class OpportunityCard extends StatelessWidget {
  final String title;
  final String category;
  final String location;
  final String description;

  const OpportunityCard({
    required this.title,
    required this.category,
    required this.location,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12.0),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text("Category: $category"),
            Text("Location: $location"),
            const SizedBox(height: 8),
            Text(description),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  // Handle the Apply Now button action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Apply Now'),
              ),
            ),
          ],
        ),
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
