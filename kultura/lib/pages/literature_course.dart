import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LiteratureCourseScreen extends StatelessWidget {
  const LiteratureCourseScreen({super.key});

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
        title: const Text('Literature Course'),
        backgroundColor: Colors.purple,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Understanding Poetry and Prose',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => _launchURL(
                  'https://youtu.be/rqqh9hg3Roc?si=uNbzEepgOAdHB4-o'), // Video 2 link
              child: Image.network(
                'https://img.youtube.com/vi/VIDEO_ID2/0.jpg',
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
