// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kultura/screens/services/job_opportunities_service.dart';

final JobOpportunitiesService jobOpportunitiesService = JobOpportunitiesService();

class OpportunitiesBoard extends StatefulWidget {
  const OpportunitiesBoard({super.key});

  @override
  State<OpportunitiesBoard> createState() => _OpportunitiesBoardState();
}

class _OpportunitiesBoardState extends State<OpportunitiesBoard> {
  String selectedCategory = "Music"; // Default category

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
      body: Column(
        children: [
          SearchBarAndFilters(
            selectedCategory: selectedCategory,
            onCategoryChanged: (category) {
              setState(() {
                selectedCategory = category;
              });

              // Navigate to the appropriate category screen
              if (category == "Painting") {
                Navigator.pushNamed(context, '/paintings_opportunities');
              } else if (category == "Literature") {
                Navigator.pushNamed(context, '/literature_opportunities');
              }
              // Remain in Music by default (OpportunitiesBoard is for Music)
            },
          ),
          Expanded(
            child: OpportunitiesList(selectedCategory: selectedCategory),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddOpportunityDialog(context),
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomNavigation(selectedIndex: 3),
    );
  }

  // Dialog to add a new opportunity
  void _showAddOpportunityDialog(BuildContext context) {
    final titleController = TextEditingController();
    final locationController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Opportunity"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Title"),
              ),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                items: ["Music", "Painting", "Literature"]
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) selectedCategory = value;
                },
                decoration: const InputDecoration(labelText: "Category"),
              ),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(labelText: "Location"),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: const Text("Add"),
              onPressed: () async {
                await jobOpportunitiesService.addOpportunity(
                  title: titleController.text,
                  category: selectedCategory,
                  location: locationController.text,
                  description: descriptionController.text,
                  createdBy: "UwDPz9tsuph75xDKjPClshSTohs2", 
                );

                // Navigate to the relevant screen after adding
                if (selectedCategory == "Music") {
                  Navigator.pushNamed(context, '/opportunities_board');
                } else if (selectedCategory == "Painting") {
                  Navigator.pushNamed(context, '/paintings_opportunities');
                } else if (selectedCategory == "Literature") {
                  Navigator.pushNamed(context, '/literature_opportunities');
                }

                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}

class SearchBarAndFilters extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategoryChanged;

  const SearchBarAndFilters({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: ["Music", "Painting", "Literature"].map((category) {
              return FilterChip(
                label: Text(category),
                selected: selectedCategory == category,
                onSelected: (bool selected) {
                  if (selected) onCategoryChanged(category);
                },
                backgroundColor: Colors.purple[100],
                selectedColor: Colors.purple,
                labelStyle: TextStyle(
                  color: selectedCategory == category ? Colors.white : Colors.black,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: const BorderSide(color: Colors.purple, width: 1),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class OpportunitiesList extends StatelessWidget {
  final String selectedCategory;

  const OpportunitiesList({
    super.key,
    required this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: jobOpportunitiesService.fetchOpportunitiesByCategory(selectedCategory),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No opportunities available."));
        }

        final opportunities = snapshot.data!.docs;

        return ListView.builder(
          itemCount: opportunities.length,
          itemBuilder: (context, index) {
            final opportunity = opportunities[index];
            return OpportunityCard(
              title: opportunity['title'],
              category: opportunity['category'],
              location: opportunity['location'],
              description: opportunity['description'],
            );
          },
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
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/resource_center');
        break;
      case 2:
        Navigator.pushNamed(context, '/search');
        break;
      case 3:
        Navigator.pushNamed(context, '/opportunities_board');
        break;
      case 4:
        Navigator.pushNamed(context, '/profile');
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
