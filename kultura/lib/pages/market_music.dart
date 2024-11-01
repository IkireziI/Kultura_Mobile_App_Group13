import 'package:flutter/material.dart';
import 'package:kultura/pages/opportunities_board.dart';

class MarketplaceMusic extends StatelessWidget {
  const MarketplaceMusic({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: SizedBox(
          width:
              double.infinity, // This makes the container take the full width
          child: Center(
            child: Image.asset(
              'assets/images/KULTURA.png',
              height: 40,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
      body: MarketplaceMusicContent(),
      bottomNavigationBar: const BottomNavigation(
          selectedIndex: 2), // Set to the index for MarketplaceMusic
    );
  }
}

// Content
class MarketplaceMusicContent extends StatelessWidget {
  const MarketplaceMusicContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SearchBarAndFilters(),
        Expanded(
          child: const MusicList(),
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
              hintText: 'Search',
              prefixIcon: Icon(Icons.search_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
            onChanged: (value) {
              // Handle search logic (if needed)
            },
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
        if (selected) {
          // Navigate to the appropriate page based on the label
          switch (label) {
            case 'Music':
              // Already on Music page
              break;
            case 'Painting':
              Navigator.pushReplacementNamed(context, '/market_painting');
              break;
            case 'Literature':
              Navigator.pushReplacementNamed(context, '/market_literature');
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

// Music List Class
class MusicList extends StatelessWidget {
  const MusicList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
