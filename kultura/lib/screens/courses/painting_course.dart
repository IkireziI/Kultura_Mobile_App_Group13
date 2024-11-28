import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PaintingCourseScreen extends StatefulWidget {
  const PaintingCourseScreen({super.key});

  @override
  PaintingCourseScreenState createState() => PaintingCourseScreenState();
}

class PaintingCourseScreenState extends State<PaintingCourseScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF9C27B0), Color(0xFFE1BEE7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Center(
                      child: Image.asset(
                        'assets/images/KULTURA.png',
                        height: 40,
                      ),
                    ),
                  ),
                  const IconButton(
                    icon: Icon(null),
                    onPressed: null,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value.toLowerCase();
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search courses',
                    hintStyle: const TextStyle(fontStyle: FontStyle.italic),
                    prefixIcon: const Icon(Icons.search, color: Colors.black),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, color: Colors.black),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchQuery = '';
                              });
                            },
                          )
                        : IconButton(
                            icon: const Icon(Icons.filter_list,
                                color: Colors.black),
                            onPressed: () {},
                          ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('painting_courses')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No Videos Available'));
                  }

                  // Filter videos based on search query
                  final filteredVideos = snapshot.data!.docs.where((video) {
                    final title = video['title'].toString().toLowerCase();
                    final description =
                        video['description'].toString().toLowerCase();
                    return title.contains(_searchQuery) ||
                        description.contains(_searchQuery);
                  }).toList();

                  if (filteredVideos.isEmpty) {
                    return const Center(
                      child: Text(
                        'No courses match your search',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: filteredVideos.length,
                    itemBuilder: (context, index) {
                      final video = filteredVideos[index];
                      return EmbeddedVideoCard(
                        videoId: video.id,
                        videoUrl: video['videoUrl'],
                        title: video['title'],
                        description: video['description'],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddVideoScreen()),
          );
        },
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}

class EmbeddedVideoCard extends StatelessWidget {
  final String videoId;
  final String videoUrl;
  final String title;
  final String description;

  const EmbeddedVideoCard({
    super.key,
    required this.videoId,
    required this.videoUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final videoIdFromUrl = YoutubePlayer.convertUrlToId(videoUrl);

    if (videoIdFromUrl == null) {
      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Invalid video URL',
                style: TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 16),
              Text(
                description,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    final YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: videoIdFromUrl,
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditVideoScreen(
                            videoId: videoId,
                            videoUrl: videoUrl,
                            title: title,
                            description: description,
                          ),
                        ),
                      );
                    } else if (value == 'delete') {
                      FirebaseFirestore.instance
                          .collection('painting_courses')
                          .doc(videoId)
                          .delete();
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Text('Edit'),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            YoutubePlayer(
              controller: controller,
              showVideoProgressIndicator: true,
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class AddVideoScreen extends StatefulWidget {
  const AddVideoScreen({super.key});

  @override
  State<AddVideoScreen> createState() => _AddVideoScreenState();
}

class _AddVideoScreenState extends State<AddVideoScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _addVideo() async {
    final title = _titleController.text;
    final url = _urlController.text;
    final description = _descriptionController.text;

    if (title.isEmpty || url.isEmpty || description.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('All fields are required')),
        );
      }
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('painting_courses').add({
        'title': title,
        'videoUrl': url,
        'description': description,
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Video added successfully')),
        );
        Navigator.pop(context);
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add video: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Video')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(labelText: 'Video URL'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addVideo,
              child: const Text('Add Video'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditVideoScreen extends StatefulWidget {
  final String videoId;
  final String videoUrl;
  final String title;
  final String description;

  const EditVideoScreen({
    super.key,
    required this.videoId,
    required this.videoUrl,
    required this.title,
    required this.description,
  });

  @override
  State<EditVideoScreen> createState() => _EditVideoScreenState();
}

class _EditVideoScreenState extends State<EditVideoScreen> {
  late TextEditingController _titleController;
  late TextEditingController _urlController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _urlController = TextEditingController(text: widget.videoUrl);
    _descriptionController = TextEditingController(text: widget.description);
  }

  void _updateVideo() async {
    final title = _titleController.text;
    final url = _urlController.text;
    final description = _descriptionController.text;

    if (title.isEmpty || url.isEmpty || description.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('All fields are required')),
        );
      }
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('painting_courses')
          .doc(widget.videoId)
          .update({
        'title': title,
        'videoUrl': url,
        'description': description,
      });

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Video')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(labelText: 'Video URL'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _updateVideo,
              child: const Text('Update Video'),
            ),
          ],
        ),
      ),
    );
  }
}
