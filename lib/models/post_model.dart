
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
