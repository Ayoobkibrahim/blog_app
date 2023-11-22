import 'package:blog_app/models/post_model.dart';
import 'package:blog_app/services/api_service.dart';
import 'package:flutter/material.dart';

class PostDetailsScreen extends StatefulWidget {
  final Post post;

  const PostDetailsScreen({Key? key, required this.post}) : super(key: key);

  @override
  _PostDetailsScreenState createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  late Post post;
  late List<Comment> comments = []; // Initialize comments as an empty list
  ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    post = widget.post;
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      comments = await _apiService.getCommentsForPost(post.id);
      setState(() {}); 
    } catch (e) {
      // Handle errors here (e.g., show an error message)
      print('Error fetching comments: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.cyanAccent,
        centerTitle: true,
        title: Text('Post Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(post.body),
            SizedBox(height: 16),
            Text(
              'Comments:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Expanded(
              child: comments.isEmpty
                  ? Center(child: CircularProgressIndicator()) // Show loading indicator if comments are being fetched
                  : ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final comment = comments[index];
                        return ListTile(
                          title: Text(comment.name),
                          subtitle: Text(comment.body),
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

















