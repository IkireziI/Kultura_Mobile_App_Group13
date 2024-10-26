import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MarketplacePage(),
    );
  }
}


class MarketplacePage extends StatelessWidget {
   const MarketplacePage({super.key}); // Add 'const' to make it a constant constructor
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'KULTURA',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.purpleAccent,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subtitle
            Text(
              'Marketplace',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.purple[100],
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Opportunities',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
            SizedBox(height: 10),

            // Filter Chips
            Row(
              children: [
                FilterChip(
                  label: Text('Music'),
                  onSelected: (value) {},
                  backgroundColor: Colors.purple[100],
                ),
                SizedBox(width: 8),
                FilterChip(
                  label: Text('Painting'),
                  onSelected: (value) {},
                  backgroundColor: Colors.purple[300],
                  selected: true,
                ),
                SizedBox(width: 8),
                FilterChip(
                  label: Text('Literature'),
                  onSelected: (value) {},
                  backgroundColor: Colors.purple[100],
                ),
              ],
            ),
            SizedBox(height: 10),

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
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 4, // Number of items in grid
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
                              image: DecorationImage(
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
                          style: TextStyle(
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
    );
  }
}