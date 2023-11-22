
import 'package:blog_app/screens/create_postscreen.dart';
import 'package:blog_app/screens/post_detailscreen.dart';
import 'package:flutter/material.dart';
import 'package:blog_app/models/post_model.dart';
import 'package:blog_app/models/user_model.dart';
import 'package:blog_app/services/api_service.dart';

class PostListScreen extends StatefulWidget {
  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  late List<Post> posts = [];
  late List<User> users = []; 
  late User selectedUser = User(id: 0, name: ''); 
  ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      posts = await _apiService.getPosts();
      users = await _apiService.getUsers();

      if (users.isNotEmpty) {
        selectedUser = users.first; 
      }

      setState(() {}); 
    } catch (e) {
      
      print('Error fetching data: $e');
    }
  }

  void _onUserChanged(User? newUser) {
    if (newUser != null) {
      setState(() {
        selectedUser = newUser;
      });
    }
  }

  void _deletePost(int postId) async {
    await _apiService.deletePost(postId);
    _fetchData();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text("Post Deleted"),
      action: SnackBarAction(label: "Undo", 
      onPressed: (){
      }),));


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.cyanAccent,
        centerTitle: true,
        title: Text('Post List',),
      ),
      body: posts.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButton<User>(
                  value: selectedUser,
                  onChanged: _onUserChanged,
                  items: users.map((user) {
                    return DropdownMenuItem<User>(
                      value: user,
                      child: Text(user.name),
                    );
                  }).toList(),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      if (post.userId == selectedUser.id) {
                        return ListTile(
                          title: Text(post.title),
                          subtitle: Text(post.body),
                          
                          onTap: () {
                   
                        Navigator.push(
                           context,
                           MaterialPageRoute(
                            builder: (context) => PostDetailsScreen(post: post),
                               ));
                          },
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _deletePost(post.id),
                          ),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ],
            ),


            floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newPost = await Navigator.push(context, MaterialPageRoute(builder: (context) =>CreatePostScreen() ));

          if(newPost != null && newPost is Post){
            setState(() {
              posts.add(newPost);
            });
          }
        },
        child: Icon(Icons.add, color: Colors.white, size: 30.0),
        backgroundColor: const Color.fromARGB(255, 95, 89, 89),
        elevation: 0.0,
      ),

    );
  }
}
