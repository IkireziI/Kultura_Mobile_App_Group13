import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MusicCourseScreen extends StatelessWidget {
  const MusicCourseScreen({super.key});

  // Function to open YouTube video using launchUrl and canLaunchUrl
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url); // Convert the string URL to Uri

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri,
          mode: LaunchMode.externalApplication); // Launch the URL
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music Course'),
        backgroundColor: Colors.purple,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigates back to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Introduction to Music Theory',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Display video thumbnail and clickable link to YouTube
            GestureDetector(
              onTap: () => _launchURL(
                  'https://www.youtube.com/watch?v=VIDEO_ID1'), // Video 1 link
              child: Image.network(
                'https://img.youtube.com/vi/VIDEO_ID1/0.jpg',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            const Text(
              'Tap the video preview to watch the full video on YouTube.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
