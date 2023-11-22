import 'package:blog_app/services/api_service.dart';
import 'package:flutter/material.dart';


class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();
  ApiService _apiService = ApiService();

  void _createPost() async {
    final title = _titleController.text.trim();
    final body = _bodyController.text.trim();

    if (title.isNotEmpty && body.isNotEmpty) {
      final newPost = await _apiService.createPost(title, body,1);
      Navigator.pop(context, newPost); 
    } else {
     
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( backgroundColor: Colors.cyanAccent,
        centerTitle: true,
        title: Text('Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _bodyController,
              decoration: InputDecoration(
                labelText: 'Body',
              ),
              maxLines: null,
            ),
            SizedBox(height: 24),
            
            ElevatedButton(
              onPressed: _createPost,
              child: Text('Create Post'),
            ),
          ],
        ),
      ),
    );
  }
}
