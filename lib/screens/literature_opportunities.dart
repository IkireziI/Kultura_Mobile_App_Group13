// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kultura/screens/services/job_opportunities_service.dart';
import 'package:kultura/screens/add_opportunity_form.dart';

class LiteratureOpportunities extends StatefulWidget {
  const LiteratureOpportunities({super.key});

  @override
  State<LiteratureOpportunities> createState() => _LiteratureBoardState();
}

class _LiteratureBoardState extends State<LiteratureOpportunities> {
  final JobOpportunitiesService jobOpportunitiesService = JobOpportunitiesService();
  String selectedCategory = "Literature";

  void _refreshOpportunities() {
    setState(() {});
  }

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
          Column(
            children: [
              SearchBarAndFilters(
                selectedCategory: selectedCategory,
                onCategoryChanged: (category) {
                  setState(() {
                    selectedCategory = category;
                  });
                },
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
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
                        final opportunity = opportunities[index].data() as Map<String, dynamic>;
                        opportunity['id'] = opportunities[index].id; // Include Firestore ID
                        return OpportunityCard(
                          opportunity: opportunity,
                          onEdit: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddOpportunityForm(
                                  existingOpportunity: opportunity,
                                  onComplete: _refreshOpportunities,
                                ),
                              ),
                            );
                          },
                          onDelete: () async {
                            try {
                              await jobOpportunitiesService.deleteOpportunity(opportunity['id']);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Opportunity deleted successfully')),
                              );
                              _refreshOpportunities();
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Failed to delete opportunity: $e')),
                              );
                            }
                          },
                          onApply: () async {
                            try {
                              await jobOpportunitiesService.applyToOpportunity(
                                  opportunity['id'], 'UwDPz9tsuph75xDKjPClshSTohs2'); // Example User ID
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Applied successfully')),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Failed to apply: $e')),
                              );
                            }
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 70.0,
            left: 16.0,
            right: 16.0,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddOpportunityForm(onComplete: _refreshOpportunities, existingOpportunity: {},),
            ),
          );
        },
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomNavigation(selectedIndex: 3),
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
    const categories = ["Music", "Painting", "Literature"];
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
            onChanged: (query) {
              // Implement search logic if needed
            },
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8.0,
            children: categories.map((category) {
              return FilterChip(
                label: Text(category),
                selected: selectedCategory == category,
                onSelected: (bool selected) {
                  if (selected) onCategoryChanged(category);
                },
                backgroundColor: Colors.purple[100],
                selectedColor: Colors.purple,
                labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
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

class OpportunityCard extends StatelessWidget {
  final Map<String, dynamic> opportunity;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onApply;

  const OpportunityCard({
    required this.opportunity,
    required this.onEdit,
    required this.onDelete,
    required this.onApply,
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
              opportunity['title'] ?? '',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text("Category: ${opportunity['category'] ?? ''}"),
            Text("Location: ${opportunity['location'] ?? ''}"),
            const SizedBox(height: 8),
            Text(opportunity['description'] ?? ''),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onEdit,
                  child: const Text('Edit'),
                ),
                TextButton(
                  onPressed: onDelete,
                  child: const Text('Delete'),
                ),
                ElevatedButton(
                  onPressed: onApply,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Apply Now'),
                ),
              ],
            ),
          ],
        ),
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
