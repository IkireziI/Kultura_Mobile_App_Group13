import 'package:flutter/material.dart';

class PaintingOpportunities extends StatelessWidget {
  const PaintingOpportunities({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        iconTheme: const IconThemeData(
            color: Colors.white), // Set back arrow color to white
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
          const PaintingBoardContent(),
          Positioned(
            bottom: 70.0,
            left: 16.0,
            right: 16.0,
            child: Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/marketplace');
                },
                icon:
                    const Icon(Icons.local_offer_outlined, color: Colors.black),
                label: const Text(
                  'Marketplace',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigation(
        selectedIndex: 3, // Adjust as necessary
      ),
    );
  }
}

class PaintingBoardContent extends StatelessWidget {
  const PaintingBoardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SearchBarAndFilters(),
        Expanded(
          child: const OpportunitiesList(category: 'Painting'), // Pass category if needed
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
  String selectedCategory = 'Painting';

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

                          if (selected) {
                            // Navigate based on the selected category
                            if (category == 'Painting') {
                              Navigator.pushNamed(
                                  context, '/paintings_opportunities');
                            } else if (category == 'Literature') {
                              Navigator.pushNamed(
                                  context, '/literature_opportunities');
                            }
                          }
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
              const SizedBox(width: 48),
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
        if (label == 'Literature' && selected) {
          Navigator.pushNamed(context, '/literature_opportunities');
        }
        if (label == 'Music' && selected) {
          Navigator.pushNamed(context, '/opportunities_board');
        }
      },
      backgroundColor: Colors.purple[100],
      selectedColor: Colors.purple,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(color: Colors.purple, width: 1),
      ),
    );
  }
}

class OpportunitiesList extends StatelessWidget {
  final String category; // Added category parameter

  const OpportunitiesList({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final opportunities = [
      {
        'title': 'Painting Exhibition',
        'category': 'Event',
        'location': 'Los Angeles, USA',
        'description': 'Join our painting exhibition showcasing local artists.',
      },
      {
        'title': 'Art Contest',
        'category': 'Contest',
        'location': 'Online',
        'description': 'Submit your best painting for a chance to win prizes.',
      },
      {
        'title': 'Art Teacher Needed',
        'category': 'Job',
        'location': 'Paris, France',
        'description': 'Seeking a painting teacher for art classes.',
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
        Navigator.pushNamed(context, '/home'); // Navigates to Home
        break;
      case 1:
        Navigator.pushNamed(context, '/resource_center'); // Navigates to Resource Center
        break;
      case 2:
        Navigator.pushNamed(context, '/search'); // Navigates to Search Screen
        break;
      case 3:
        Navigator.pushNamed(context, '/opportunities_board'); // Navigates to Opportunities board
        break;
      case 4:
        Navigator.pushNamed(context, '/profile'); // Navigates to Profile Screen
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
