import 'package:flutter/material.dart';
import 'package:kultura/pages/resource_center.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// Stateless widget for the Literature Course Screen
class LiteratureCourseScreen extends StatelessWidget {
  const LiteratureCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gradient background for the screen
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF9C27B0),
              Color(0xFFE1BEE7)
            ], // Purple gradient colors
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Custom App Bar with back button and logo
            AppBar(
              elevation: 0, // No shadow
              backgroundColor: Colors.transparent, // Transparent background
              leading: IconButton(
                icon: const Icon(Icons.arrow_back,
                    color: Colors.white), // Back button icon
                onPressed: () {
                  Navigator.pop(context); // Navigate back to previous screen
                },
              ),
              title: Center(
                // Centering the image logo in the AppBar
                child: Image.asset(
                  'assets/images/KULTURA.png', // Logo image path
                  height: 40, // Height of the logo
                ),
              ),
            ),
            const SizedBox(height: 16), // Spacer

            // Search Bar with an italic hint text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white
                      .withOpacity(0.8), // Semi-transparent white background
                  borderRadius: BorderRadius.circular(30), // Rounded corners
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search', // Hint text in search bar
                    hintStyle: const TextStyle(
                      fontStyle: FontStyle.italic, // Italic hint text style
                    ),
                    prefixIcon: const Icon(Icons.search,
                        color: Colors.black), // Search icon
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.filter_list,
                          color: Colors.black), // Filter icon
                      onPressed: () {
                        // Handle filter action (to be implemented)
                      },
                    ),
                    border: InputBorder.none, // No border for the text field
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16), // Spacer

            // Section for embedded videos
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      // First embedded video card
                      EmbeddedVideoCard(
                        videoUrl:
                            'https://youtu.be/xz9rfDm1Wr4?si=kECr31PSHMMnyhly',
                        title:
                            'An Introduction to the Discipline of Literature', // Video title
                        description:
                            'What is Literature and why should we study it? This short video from Macat explains how the subject has developed over the years and introduces some of the key ideas and major thinkers who have helped to shape it.', // Video description
                      ),
                      const SizedBox(height: 16), // Spacer
                      // Second embedded video card
                      EmbeddedVideoCard(
                        videoUrl:
                            'https://youtu.be/Pp7fjHWcTRQ?si=M30kdaJQOLq0T079',
                        title: 'Prose Literature', // Video title
                        description:
                            'Types of Prose Literature | Fiction, Non-Fiction and Subtypes of Prose Literature.', // Video description
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // Bottom navigation bar with selected index
      bottomNavigationBar: const BottomNavigation(
          selectedIndex: 1), // Selected index for highlighting the current page
    );
  }
}

// Custom Embedded Video Card Widget
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
  late YoutubePlayerController _controller; // Controller for the Youtube player

  @override
  void initState() {
    super.initState();
    // Initialize the Youtube player controller with the video URL
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
          widget.videoUrl)!, // Extract video ID from URL
      flags: const YoutubePlayerFlags(
        autoPlay: false, // Do not autoplay the video
        mute: false, // Do not mute the video
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller to free resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Elevation for card shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Rounded corners for the card
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align children to the start
          children: [
            // Title of the video
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 18, // Font size of the title
                fontWeight: FontWeight.bold, // Bold title
              ),
            ),
            const SizedBox(height: 8), // Spacer
            // Video player
            YoutubePlayer(
              controller: _controller, // Controller for the video player
              showVideoProgressIndicator: true, // Show video progress indicator
            ),
            const SizedBox(height: 16), // Spacer
            // Description of the video
            Text(
              widget.description,
              style: const TextStyle(
                  fontSize: 14, color: Colors.grey), // Description text style
            ),
          ],
        ),
      ),
    );
  }
}
