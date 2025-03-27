import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'locales.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: context.formatString(LocaleData.body110, ["heba"]),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FreelancerPage(),
    );
  }
}

class FreelancerPage extends StatefulWidget {
  @override
  _FreelancerPageState createState() => _FreelancerPageState();
}

class _FreelancerPageState extends State<FreelancerPage> {
  List<Post> posts = [];
  String currentUser = "User1"; // Simulated current user

  // List of fake names and their corresponding profile pictures
  final List<Map<String, String>> users = [
    {
      'name': 'Alice Johnson',
      'picture': 'https://via.placeholder.com/40/FF5733/FFFFFF?text=A',
      'email': 'alice@example.com', // Added email for correspondence
    },
    {
      'name': 'Bob Smith',
      'picture': 'https://via.placeholder.com/40/33C1FF/FFFFFF?text=B',
      'email': 'bob@example.com', // Added email for correspondence
    },
    {
      'name': 'Charlie Brown',
      'picture': 'https://via.placeholder.com/40/FF33A6/FFFFFF?text=C',
      'email': 'charlie@example.com', // Added email for correspondence
    },
  ];

  @override
  void initState() {
    super.initState();
    addFakePost(); // Add a fake post on initialization
  }

  void addFakePost() {
    setState(() {
      posts.add(Post(

        content: 'this is fake post',
        author: users[0]['name']!,
        profilePicture: users[0]['picture']!,
        email: users[0]['email']!,
      ));
    });
  }

  void addPost(String content) {
    setState(() {
      final user = users[DateTime.now().millisecondsSinceEpoch % users.length];
      posts.add(Post(
        content: content,
        author: user['name']!,
        profilePicture: user['picture']!,
        email: user['email']!,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleData.body110.getString(context)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return PostWidget(post: posts[index], currentUser: currentUser);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  addPost(value);
                }
              },
              decoration: InputDecoration(
                labelText: context.formatString(LocaleData.body112, ["heba"]),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Post {
  String content;
  String author;
  String profilePicture;
  String email;
  int likeCount;
  List<String> comments;

  Post({
    required this.content,
    required this.author,
    required this.profilePicture,
    required this.email,
    this.likeCount = 0,
    this.comments = const [],
  });
}

class PostWidget extends StatefulWidget {
  final Post post;
  final String currentUser;

  const PostWidget({required this.post, required this.currentUser});

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  final TextEditingController _messageController = TextEditingController();

  void addComment(String comment) {
    setState(() {
      widget.post.comments.add(comment);
    });
  }

  void likePost() {
    setState(() {
      widget.post.likeCount++;
    });
  }

  void sendEmail() async {
    if (_messageController.text.isNotEmpty) {
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: widget.post.email,
        query: 'subject=New Message&body=${Uri.encodeComponent(_messageController.text)}',
      );
      await launch(emailLaunchUri.toString());
      _messageController.clear(); // Clear the message field after sending
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.post.profilePicture),
                  radius: 20,
                ),
                SizedBox(width: 8),
                Text(widget.post.author, style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 10),
            Text(widget.post.content, style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: likePost,
                  icon: Icon(Icons.thumb_up),
                  label: Text(' (${widget.post.likeCount})'),
                ),
                Row(
                  children: [
                    Container(
                      width: 120,
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          labelText: context.formatString(LocaleData.body111, ["heba"]),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: sendEmail, // Send email instead of direct message
                    ),
                  ],
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.post.comments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.post.comments[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () => Share.share(widget.post.comments[index]),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
