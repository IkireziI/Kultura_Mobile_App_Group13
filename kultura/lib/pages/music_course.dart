import 'package:flutter/material.dart';
import 'package:kultura/pages/resource_center.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// Main screen for the Music Course
class MusicCourseScreen extends StatelessWidget {
  const MusicCourseScreen({super.key});

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
            ], // Purple gradient colors
            begin: Alignment.topCenter, // Gradient starts from the top
            end: Alignment.bottomCenter, // Gradient ends at the bottom
          ),
        ),
        child: Column(
          children: [
            // Custom App Bar with back button and logo
            AppBar(
              elevation: 0, // No shadow effect
              backgroundColor: Colors.transparent, // Transparent background
              leading: IconButton(
                icon: const Icon(Icons.arrow_back,
                    color: Colors.white), // Back button icon
                onPressed: () {
                  Navigator.pop(context); // Go back to the previous screen
                },
              ),
              title: Center(
                // Centering the image logo
                child: Image.asset(
                  'assets/images/KULTURA.png', // Logo asset
                  height: 40, // Height of the logo
                ),
              ),
            ),
            const SizedBox(height: 16), // Spacing

            // Search bar with centered italic text
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0), // Padding for the search bar
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white
                      .withOpacity(0.8), // White background with opacity
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
                        // Handle filter action here
                      },
                    ),
                    border: InputBorder.none, // No border around the text field
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16), // Spacing

            // Scrollable area for embedded videos
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0), // Padding for video cards
                  child: Column(
                    children: [
                      // First embedded video card
                      EmbeddedVideoCard(
                        videoUrl:
                            'https://www.youtube.com/watch?v=dQw4w9WgXcQ', // Video URL
                        title: 'Music Theory Basics', // Video title
                        description:
                            'Learn the fundamentals of music theory in this introduction.', // Video description
                      ),
                      const SizedBox(height: 16), // Spacing between video cards
                      // Second embedded video card
                      EmbeddedVideoCard(
                        videoUrl:
                            'https://www.youtube.com/watch?v=3JZ_D3ELwOQ', // Video URL
                        title: 'How to Play Guitar', // Video title
                        description:
                            'This video covers the basics of playing guitar.', // Video description
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          const BottomNavigation(selectedIndex: 1), // Bottom navigation bar
    );
  }
}

// Custom widget for displaying an embedded video card
class EmbeddedVideoCard extends StatefulWidget {
  final String videoUrl; // URL of the YouTube video
  final String title; // Title of the video
  final String description; // Description of the video

  const EmbeddedVideoCard({
    super.key,
    required this.videoUrl,
    required this.title,
    required this.description,
  });

  @override
  EmbeddedVideoCardState createState() =>
      EmbeddedVideoCardState(); // Create the state for the video card
}

class EmbeddedVideoCardState extends State<EmbeddedVideoCard> {
  late YoutubePlayerController _controller; // Controller for the YouTube player

  @override
  void initState() {
    super.initState();
    // Initialize the YouTube player controller with the video URL
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
          widget.videoUrl)!, // Convert URL to video ID
      flags: const YoutubePlayerFlags(
        autoPlay: false, // Do not auto-play the video
        mute: false, // Sound is not muted
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller when done
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
        padding: const EdgeInsets.all(16.0), // Padding inside the card
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align text to the start
          children: [
            // Title of the video
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 18, // Font size for the title
                fontWeight: FontWeight.bold, // Bold font weight for the title
              ),
            ),
            const SizedBox(height: 8), // Spacing below the title
            // YouTube player widget
            YoutubePlayer(
              controller: _controller, // Provide the controller
              showVideoProgressIndicator: true, // Show progress indicator
            ),
            const SizedBox(height: 16), // Spacing below the video
            // Description of the video
            Text(
              widget.description,
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey), // Style for the description
            ),
          ],
        ),
      ),
    );
  }
}
