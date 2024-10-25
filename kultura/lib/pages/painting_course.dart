import 'package:flutter/material.dart';
import 'package:kultura/pages/resource_center.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PaintingCourseScreen extends StatelessWidget {
  const PaintingCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gradient background
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF9C27B0), Color(0xFFE1BEE7)], // Purple gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Custom App Bar with image logo
            AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Center(
                // Center the image
                child: Image.asset(
                  'assets/images/KULTURA.png',
                  height: 40,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Search Bar with centered italic text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: const TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                    prefixIcon: const Icon(Icons.search, color: Colors.black),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.filter_list, color: Colors.black),
                      onPressed: () {
                        // Handle filter action
                      },
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Embedded Videos
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      // Embedded video
                      EmbeddedVideoCard(
                        videoUrl: 'https://youtu.be/rcfMSeilPkg?si=2FGH7DpHzXazyz2u',
                        title: 'Paint ANYTHING in just 4 Simple Steps!',
                        description:
                            'This four-step painting method will help you create realistic and expressive artwork.',
                      ),
                      const SizedBox(height: 16),
                      EmbeddedVideoCard(
                        videoUrl: 'https://youtu.be/UO1qql_4WSA?si=8KpzdZHCs7PZJV0H',
                        title: '50 Easy Acrylic Painting Ideas for Beginners',
                        description:
                            'Here is a showcase of every painting Cheloc Arts made in 2022, find your inspo.',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(selectedIndex: 1), // Bottom Nav
    );
  }
}

// Custom Embedded Video Card Widget
class EmbeddedVideoCard extends StatefulWidget {
  final String videoUrl;
  final String title;
  final String description;

  const EmbeddedVideoCard({
    super.key,
    required this.videoUrl,
    required this.title,
    required this.description,
  });

  @override
  EmbeddedVideoCardState createState() => EmbeddedVideoCardState();
}

class EmbeddedVideoCardState extends State<EmbeddedVideoCard> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl)!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video player
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
            ),
            const SizedBox(height: 16),

            // Title and description
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.description,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
