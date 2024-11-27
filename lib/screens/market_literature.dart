import 'package:flutter/material.dart';

class MarketplaceLiterature extends StatelessWidget {
  const MarketplaceLiterature({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: SizedBox(
          width: double.infinity, // Makes the container take the full width
          child: Center(
            child: Image.asset(
              'assets/images/KULTURA.png',
              height: 40,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
      // Main body content for the page
      body: const MarketplaceLiteratureContent(),
      bottomNavigationBar: const BottomNavigation(
        selectedIndex: 3, // Sets the OpportunitiesBoard as the selected tab
      ),
    );
  }
}

// Main content of the Marketplace Literature page
class MarketplaceLiteratureContent extends StatelessWidget {
  const MarketplaceLiteratureContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search bar and filters section
        const SearchBarAndFilters(),
        // Expanded list of literature opportunities
        const Expanded(
          child: LiteratureList(),
        ),
      ],
    );
  }
}

// Search bar and filter chips for filtering opportunities
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
              prefixIcon: const Icon(Icons.search_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
          const SizedBox(height: 16), // Space between search bar and filters
          // Filter chips for categories (Music, Painting, Literature)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              CustomFilterChip(label: 'Music', isSelected: false),
              CustomFilterChip(label: 'Painting', isSelected: false),
              CustomFilterChip(label: 'Literature', isSelected: true),
            ],
          ),
        ],
      ),
    );
  }
}

// Custom filter chip for selecting categories
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
        if (selected) {
          // Navigate to the corresponding filter screen
          switch (label) {
            case 'Music':
              Navigator.pushReplacementNamed(context, '/marketplace_music');
              break;
            case 'Painting':
              Navigator.pushReplacementNamed(context, '/marketplace_painting');
              break;
            case 'Literature':
              Navigator.pushReplacementNamed(
                  context, '/marketplace_literature');
              break;
          }
        }
      },
      selectedColor: Colors.purple,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
      ),
    );
  }
}

// List of literature opportunities
class LiteratureList extends StatelessWidget {
  const LiteratureList({super.key});

  @override
  Widget build(BuildContext context) {
    // Temporary mock data for literature items
    final List<String> literatureItems = [
      'Classic Literature 1',
      'Modern Poetry',
      'Historical Fiction',
      'Science Fiction Novels',
      'Literary Criticism'
    ];

    return ListView.builder(
      itemCount: literatureItems.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(literatureItems[index]),
          onTap: () {
            // Define actions on tap, like navigating to a detail screen
          },
        );
      },
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
        Navigator.pushReplacementNamed(context, '/home'); // Home screen
        break;
      case 1:
        Navigator.pushReplacementNamed(
            context, '/resource_center'); // Resource Center
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/search'); // Search Screen
        break;
      case 3:
        Navigator.pushReplacementNamed(
            context, '/opportunities_board'); // Opportunities Board
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/profile'); // Profile Screen
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
