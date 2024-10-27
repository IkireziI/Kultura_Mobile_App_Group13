import 'package:flutter/material.dart';
import 'package:kultura/pages/opportunities_board.dart';

class MarketplacePainting extends StatelessWidget {
  const MarketplacePainting({super.key});

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
      // Main body content for the page
      body: MarketplacePaintingContent(),
      bottomNavigationBar: const BottomNavigation(
          selectedIndex:
              3), // Update selectedIndex to the appropriate tab index for the OpportunitiesBoard
    );
  }
}

// Content
class MarketplacePaintingContent extends StatelessWidget {
  const MarketplacePaintingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search bar and filters section
        const SearchBarAndFilters(),
        // Expanded list of opportunities
        Expanded(
          child: const PaintsList(),
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
          ),
          const SizedBox(height: 16), // Space between search bar and filters
          // Filter chips (Music, Painting, Literature)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              CustomFilterChip(label: 'Music', isSelected: false),
              CustomFilterChip(label: 'Painting', isSelected: true),
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

// Paints List Class
class PaintsList extends StatelessWidget {
  const PaintsList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

