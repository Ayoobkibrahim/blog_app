// // To parse this JSON data, do
// //
// //     final post = postFromJson(jsonString);

// import 'dart:convert';

// List<Post> postFromJson(String str) => List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

// String postToJson(List<Post> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
    int userId;
    int id;
    String title;
    String body;

    Post({
        required this.userId,
        required this.id,
        required this.title,
        required this.body,
    }
 );}

class Comment {
    int postId;
    int id;
    String name;
    String email;
    String body;

    Comment({
        required this.postId,
        required this.id,
        required this.name,
        required this.email,
        required this.body,
    });
}






//     factory Post.fromJson(Map<String, dynamic> json) => Post(
//         userId: json["userId"],
//         id: json["id"],
//         title: json["title"],
//         body: json["body"],
//     );

//     Map<String, dynamic> toJson() => {
//         "userId": userId,
//         "id": id,
//         "title": title,
//         "body": body,
//     };
// }














// post.dart
// class Post {
//   final int id;
//   final int userId;
//   final String title;
//   final String body;

//   Post({required this.id, required this.userId, required this.title, required this.body});
// }

// comment.dart
// class Comment {
//   final int id;
//   final int postId;
//   final String name;
//   final String email;
//   final String body;

//   Comment({required this.id, required this.postId, required this.name, required this.email, required this.body});
// }

// user.dart
// class User {
//   final int id;
//   final String name;

//   User({required this.id, required this.name});
// }
