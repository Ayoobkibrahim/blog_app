
import 'dart:convert';
import 'package:blog_app/models/post_model.dart';
import 'package:blog_app/models/user_model.dart';
import 'package:http/http.dart' as http;


class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/';

  Future<List<Post>> getPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));
    if (response.statusCode == 200) {
      Iterable data = json.decode(response.body);
      return List<Post>.from(data.map((post) => Post(
        id: post['id'],
        userId: post['userId'],
        title: post['title'],
        body: post['body'],
      )));
    } else {
      throw Exception('Failed to load posts');
    }
  }
Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));
    if (response.statusCode == 200) {
      Iterable data = json.decode(response.body);
      return List<User>.from(data.map((user) => User(
        id: user['id'],
        name: user['name'],
      )));
    } else {
      throw Exception('Failed to load users');
    }
  }

   Future<void> deletePost(int postId) async {
    final response = await http.delete(Uri.parse('$baseUrl/posts/$postId'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete post');
    }
  }

Future<List<Comment>> getCommentsForPost(int postId) async {
    final response = await http.get(Uri.parse('$baseUrl/posts/$postId/comments'));
    if (response.statusCode == 200) {
      Iterable data = json.decode(response.body);
      return List<Comment>.from(data.map((comment) => Comment(
        id: comment['id'],
        postId: comment['postId'],
        name: comment['name'],
        email: comment['email'],
        body: comment['body'],
      )));
    } else {
      throw Exception('Failed to load comments for post');
    }
  }

   Future<Post> createPost(String title, String body, int userId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/posts'),
      body: jsonEncode({
        'title': title,
        'body': body,
        'userId': userId,
      }),
      headers: {'Content-type': 'application/json; charset=UTF-8'},
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      return Post(
        id: data['id'],
        userId: data['userId'],
        title: data['title'],
        body: data['body'],
      );
    } else {
      throw Exception('Failed to create post');
    }
  }





}
  

