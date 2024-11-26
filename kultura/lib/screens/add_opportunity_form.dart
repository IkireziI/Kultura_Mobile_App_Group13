import 'package:flutter/material.dart';
import 'package:kultura/screens/services/job_opportunities_service.dart';

class AddOpportunityForm extends StatefulWidget {
  final VoidCallback onComplete;

  const AddOpportunityForm({super.key, required this.onComplete, required Map<String, dynamic> existingOpportunity});

  @override
  // ignore: library_private_types_in_public_api
  _AddOpportunityFormState createState() => _AddOpportunityFormState();
}

class _AddOpportunityFormState extends State<AddOpportunityForm> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  String _location = '';
  String _category = '';

  final JobOpportunitiesService _jobService = JobOpportunitiesService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Opportunity')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                onSaved: (value) => _title = value ?? '',
                validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (value) => _description = value ?? '',
                validator: (value) => value!.isEmpty ? 'Please enter a description' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Location'),
                onSaved: (value) => _location = value ?? '',
                validator: (value) => value!.isEmpty ? 'Please enter a location' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Category'),
                onSaved: (value) => _category = value ?? '',
                validator: (value) => value!.isEmpty ? 'Please enter a category' : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    await _jobService.addOpportunity({
                      'title': _title,
                      'description': _description,
                      'location': _location,
                      'category': _category,
                      'createdAt': DateTime.now(),
                    });
                    widget.onComplete();
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  }
                },
                child: const Text('Save Opportunity'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
