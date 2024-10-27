import 'package:flutter/material.dart';

class MarketplacePage extends StatelessWidget {
  const MarketplacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: SizedBox(
            height: 40,
            child: Center(
              child: Image.asset(
                'assets/images/KULTURA.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Marketplace',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Search and Filters Section
            const SearchAndFilters(),
            const SizedBox(height: 10),

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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 4,
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
                              image: const DecorationImage(
                                image: NetworkImage(
                                  'https://cdn.shopify.com/s/files/1/0369/6522/0411/files/a16fd418-b113-4a17-890b-ed277c0197f8_600x600.jpg?v=1698914599',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          index % 2 == 0 ? '25,000 RWF' : '68,000 RWF',
                          style: const TextStyle(
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
      bottomNavigationBar: const BottomNavigation(selectedIndex: 3),
    );
  }
}

class SearchAndFilters extends StatefulWidget {
  const SearchAndFilters({super.key});

  @override
  State<SearchAndFilters> createState() => _SearchAndFiltersState();
}

class _SearchAndFiltersState extends State<SearchAndFilters> {
  bool _isFilterVisible = false;
  String selectedCategory = 'Music';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Box matching Opportunities screen
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

        // Categories and Filter Row
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
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

              // Categories in a single row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: ['Music', 'Painting', 'Literature'].map((category) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: FilterChip(
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
                        side: const BorderSide(color: Colors.purple, width: 1),
                      ),
                    ),
                  );
                }).toList(),
              ),

              // Padding at the end for better scrolling
              const SizedBox(width: 16),
            ],
          ),
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
    );
  }
}

// Bottom Navigation Bar (unchanged)
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
