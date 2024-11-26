// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kultura/screens/services/job_opportunities_service.dart';
import 'package:kultura/screens/add_opportunity_form.dart';

class OpportunitiesBoard extends StatefulWidget {
  const OpportunitiesBoard({super.key});

  @override
  State<OpportunitiesBoard> createState() => _OpportunitiesBoardState();
}

class _OpportunitiesBoardState extends State<OpportunitiesBoard> {
  final JobOpportunitiesService jobOpportunitiesService = JobOpportunitiesService();
  String selectedCategory = "Music";

  void _refreshOpportunities() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the Add Opportunity Form for adding a new opportunity
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddOpportunityForm(
                onComplete: _refreshOpportunities,
              ),
            ),
          );
        },
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add),
      ),
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
      margin: const EdgeInsets.all(18.0),
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

