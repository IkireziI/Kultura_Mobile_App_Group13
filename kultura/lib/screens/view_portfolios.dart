import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewPortfoliosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Portfolios')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('portfolios')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No portfolios found.'));
          }

          final portfolios = snapshot.data!.docs;

          return ListView.builder(
            itemCount: portfolios.length,
            itemBuilder: (context, index) {
              final portfolio = portfolios[index];
              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text(portfolio['title'] ?? 'No Title'),
                  subtitle: Text(portfolio['description'] ?? 'No Description'),
                  leading: portfolio['imageUrl'] != null &&
                      portfolio['imageUrl']!.isNotEmpty
                      ? Image.network(
                    portfolio['imageUrl'],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  )
                      : Icon(Icons.image),
                  trailing: Text(
                    portfolio['createdAt'] != null
                        ? DateTime.parse(portfolio['createdAt'])
                        .toLocal()
                        .toString()
                        : 'Unknown',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
