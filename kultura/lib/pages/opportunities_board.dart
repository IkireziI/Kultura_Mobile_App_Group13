import 'package:flutter/material.dart';

class OpportunitiesBoard extends StatelessWidget {
  const OpportunitiesBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kultura"),
        backgroundColor: Colors.purple,
      ),
      //Main body content for the page
      body: OpportunitiesBoardContent(),
      //BottomNavigationBar
      bottomNavigationBar: BottomNavigation(),
    );
  }
}

class OpportunitiesBoardContent extends StatelessWidget {
  const OpportunitiesBoardContent({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Search bar and filters section
        const SearchBarAndFilters(),
        //Expanded list of opportunities
        Expanded(
          child: const OpportunitiesList(),
        ),
      ],
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
              hintText: 'Search Opportunities',
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

// Custom filter chip widget
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

// List of opportunities (Music Teacher, Rock Band Audition, etc.)
class OpportunitiesList extends StatelessWidget {
  const OpportunitiesList({super.key});
  @override
  Widget build(BuildContext context) {
    // Sample Opportunities List
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

// Card widget for each opportunity
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
        BottomNavigationBarItem(icon: Icon(Icons.auto_stories_outlined), label: 'Stories'),
        BottomNavigationBarItem(icon: Icon(Icons.search_outlined), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.language_outlined), label: 'Global'),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: 'Profile'),
      ],
    );
  }
}

