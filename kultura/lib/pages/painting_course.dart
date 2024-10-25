import 'package:flutter/material.dart';
import 'package:kultura/pages/resource_center.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// Main screen for the Painting Course
class PaintingCourseScreen extends StatelessWidget {
  const PaintingCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Main body of the screen with a gradient background
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF9C27B0),
              Color(0xFFE1BEE7)
            ], // Gradient colors (purple)
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Custom App Bar with a logo and back button
            AppBar(
              elevation: 0, // No shadow under the AppBar.
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false, // No default back button.
              title: Row(
                children: [
                  IconButton(
                    // Custom back button that navigates to the previous screen.
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Center(
                      child: Image.asset(
                        'assets/images/KULTURA.png', // App logo.
                        height: 40, // Logo height.
                      ),
                    ),
                  ),
                  // Empty IconButton for layout symmetry.
                  const IconButton(
                    icon: Icon(null),
                    onPressed: null,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16), // Spacing below AppBar.

            // Search bar with an input field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white
                      .withOpacity(0.8), // Semi-transparent background
                  borderRadius: BorderRadius.circular(30), // Rounded corners
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search', // Placeholder text
                    hintStyle: const TextStyle(
                      fontStyle: FontStyle.italic, // Italic style for hint text
                    ),
                    prefixIcon: const Icon(Icons.search,
                        color: Colors.black), // Search icon
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.filter_list,
                          color: Colors.black), // Filter icon
                      onPressed: () {
                        // Handle filter action (functionality to be implemented)
                      },
                    ),
                    border: InputBorder.none, // No border for the input field
                  ),
                ),
              ),
            ),
            const SizedBox(
                height: 16), // Space between search bar and video list

            // Section for embedded videos
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      // First embedded video
                      EmbeddedVideoCard(
                        videoUrl:
                            'https://youtu.be/rcfMSeilPkg?si=2FGH7DpHzXazyz2u',
                        title: 'Paint ANYTHING in just 4 Simple Steps!',
                        description:
                            'This four-step painting method will help you create realistic and expressive artwork.',
                      ),
                      const SizedBox(height: 16), // Space between videos
                      // Second embedded video
                      EmbeddedVideoCard(
                        videoUrl:
                            'https://youtu.be/UO1qql_4WSA?si=8KpzdZHCs7PZJV0H',
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
      // Bottom navigation bar with the selected index
      bottomNavigationBar: const BottomNavigation(selectedIndex: 1),
    );
  }
}

// Custom widget for displaying an embedded video card
class EmbeddedVideoCard extends StatefulWidget {
  final String videoUrl; // URL of the video
  final String title; // Title of the video
  final String description; // Description of the video

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
  late YoutubePlayerController _controller; // Controller for the YouTube player

  @override
  void initState() {
    super.initState();
    // Initialize the YouTube player controller with the video URL
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl)!,
      flags: const YoutubePlayerFlags(
        autoPlay: false, // Do not auto-play the video
        mute: false, // Start with sound on
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is removed from the widget tree
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Shadow effect for the card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Rounded corners for the card
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video title
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 18, // Font size for title
                fontWeight: FontWeight.bold, // Bold font style
              ),
            ),
            const SizedBox(height: 8), // Space between title and video player
            // YouTube player widget
            YoutubePlayer(
              controller: _controller, // Pass the controller to the player
              showVideoProgressIndicator: true, // Show video progress indicator
            ),
            const SizedBox(
                height: 16), // Space between video player and description
            // Video description
            Text(
              widget.description,
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey), // Grey text for description
            ),
          ],
        ),
      ),
    );
  }
}
