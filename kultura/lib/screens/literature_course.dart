import 'package:flutter/material.dart';
import 'package:kultura/screens/courses/resource_center.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// A StatelessWidget representing the main screen of the Literature course.
class LiteratureCourseScreen extends StatelessWidget {
  const LiteratureCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Background gradient decoration for the entire screen.
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF9C27B0), Color(0xFFE1BEE7)], // Purple shades.
            begin: Alignment.topCenter, // Starts gradient from the top.
            end: Alignment.bottomCenter, // Ends gradient at the bottom.
          ),
        ),
        child: Column(
          children: [
            // Custom AppBar with transparent background for a seamless layout.
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

            // Search Bar section.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8), // Slightly transparent.
                  borderRadius: BorderRadius.circular(30), // Rounded edges.
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search', // Placeholder text.
                    hintStyle: const TextStyle(fontStyle: FontStyle.italic),
                    prefixIcon: const Icon(Icons.search,
                        color: Colors.black), // Search icon.
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.filter_list,
                          color: Colors.black), // Filter icon.
                      onPressed: () {
                        // Handle filter action.
                      },
                    ),
                    border: InputBorder.none, // No underline/border.
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16), // Spacing below Search Bar.

            // Video content section with scrolling functionality.
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      // Embedded video card for the first video.
                      EmbeddedVideoCard(
                        videoUrl:
                            'https://youtu.be/xz9rfDm1Wr4?si=kECr31PSHMMnyhly',
                        title:
                            'An Introduction to the Discipline of Literature',
                        description:
                            'What is Literature and why should we study it? This short video from Macat explains how the subject has developed over the years and introduces some of the key ideas and major thinkers who have helped to shape it.',
                      ),
                      const SizedBox(
                          height: 16), // Spacing between video cards.
                      // Embedded video card for the second video.
                      EmbeddedVideoCard(
                        videoUrl:
                            'https://youtu.be/Pp7fjHWcTRQ?si=M30kdaJQOLq0T079',
                        title: 'Prose Literature',
                        description:
                            'Types of Prose Literature | Fiction, Non-Fiction and Subtypes of Prose Literature.',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar:
      //     const BottomNavigation(selectedIndex: 1), // Bottom nav bar.
    );
  }
}

// A StatefulWidget that embeds a YouTube video with a title and description.
class EmbeddedVideoCard extends StatefulWidget {
  final String videoUrl; // URL for the video to be displayed.
  final String title; // Title of the video.
  final String description; // Description of the video.

  const EmbeddedVideoCard({
    super.key,
    required this.videoUrl,
    required this.title,
    required this.description,
  });

  @override
  EmbeddedVideoCardState createState() => EmbeddedVideoCardState();
}

// State class for the EmbeddedVideoCard widget.
class EmbeddedVideoCardState extends State<EmbeddedVideoCard> {
  late YoutubePlayerController _controller; // Controller for YouTube Player.

  @override
  void initState() {
    super.initState();
    // Initializing the YouTube player with video ID from URL.
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl)!,
      flags: const YoutubePlayerFlags(
        autoPlay: false, // Video doesn't auto-play.
        mute: false, // Video sound is not muted.
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller to free resources.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Shadow effect for the card.
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Rounded corners.
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Inner padding.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Displaying video title in bold.
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8), // Spacing below the title.
            // YouTube video player widget.
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true, // Shows video progress.
            ),
            const SizedBox(height: 16), // Spacing below the video player.
            // Video description text.
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
