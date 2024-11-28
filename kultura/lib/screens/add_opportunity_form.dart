import 'package:flutter/material.dart';
import 'package:kultura/screens/services/job_opportunities_service.dart';

class AddOpportunityForm extends StatefulWidget {
  final VoidCallback onComplete;
  final Map<String, dynamic>? existingOpportunity;

  const AddOpportunityForm({
    super.key,
    required this.onComplete,
    this.existingOpportunity, // Optional parameter for editing
  });

  @override
  State<AddOpportunityForm> createState() => _AddOpportunityFormState();
}

class _AddOpportunityFormState extends State<AddOpportunityForm> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  String _location = '';
  String _category = '';

  final JobOpportunitiesService _jobService = JobOpportunitiesService();

  @override
  void initState() {
    super.initState();
    // If there's an existing opportunity, pre-fill the fields
    if (widget.existingOpportunity != null) {
      _title = widget.existingOpportunity!['title'];
      _description = widget.existingOpportunity!['description'];
      _location = widget.existingOpportunity!['location'];
      _category = widget.existingOpportunity!['category'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingOpportunity != null ? 'Edit Opportunity' : 'Add Opportunity'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(labelText: 'Title'),
                onSaved: (value) => _title = value ?? '',
                validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
              ),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (value) => _description = value ?? '',
                validator: (value) => value!.isEmpty ? 'Please enter a description' : null,
              ),
              TextFormField(
                initialValue: _location,
                decoration: const InputDecoration(labelText: 'Location'),
                onSaved: (value) => _location = value ?? '',
                validator: (value) => value!.isEmpty ? 'Please enter a location' : null,
              ),
              TextFormField(
                initialValue: _category,
                decoration: const InputDecoration(labelText: 'Category'),
                onSaved: (value) => _category = value ?? '',
                validator: (value) => value!.isEmpty ? 'Please enter a category' : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final opportunityData = {
                      'title': _title,
                      'description': _description,
                      'location': _location,
                      'category': _category,
                      'createdAt': DateTime.now(),
                    };

                    if (widget.existingOpportunity != null) {
                      // If editing, update the opportunity
                      await _jobService.updateOpportunity(
                        widget.existingOpportunity!['id'], opportunityData);
                    } else {
                      // If adding a new opportunity
                      await _jobService.addOpportunity(opportunityData);
                    }

                    widget.onComplete();
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.existingOpportunity != null ? 'Save Changes' : 'Save Opportunity'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
