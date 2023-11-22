import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialapp/core/posts/model/post_model.dart';
import 'package:socialapp/core/posts/view_model/image_view_model.dart';
// import 'post_view_model.dart';

class PostWidget extends StatelessWidget {
  final PostViewModel postViewModel = Get.put(PostViewModel());

  final List<ImageModel> posts;

  //  PostWidget({super.key, required this.posts});
  PostWidget({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return ListView.builder(
    itemCount: posts.length,
    itemBuilder: (context, index) {
      final post = posts[index];
      return Card(
        margin: EdgeInsets.all(8.0),
        child: ListTile(
          contentPadding: EdgeInsets.zero, // Remove default padding
          title: Text(post.text, style: TextStyle(color: Colors.red),),
          leading: post.imageFile != null
              ? Container(
                  width: 10.0, // Set a specific width
                  height: 10.0, // Set a specific height
                  child: Image.file(post.imageFile!),
                )
              : Container(),
        ),
      );
    },
  );
}


  Widget _buildPostImage(String? imageUrl) {
    return imageUrl != null
        ? CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) => CircularProgressIndicator(),
         //   errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
            width: 80.0, // Adjust the width as needed
            height: 80.0, // Adjust the height as needed
          )
        : Container(
            child: Text('Nothing to display'),
          ); // Return an empty container if no image URL is provided
  }

  Widget _buildLikeButton(ImageModel post) {
    return IconButton(
      icon: Icon(Icons.favorite, color: post.likes > 0 ? Colors.red : null),
      onPressed: () => postViewModel.likePost(post),
    );
  }

  void _showCommentsDialog(BuildContext context, ImageModel post) {
    // Implement a dialog to show comments and allow users to add comments
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Comments'),
          content: Column(
            children: [
              _buildCommentsList(post),
              _buildAddCommentTextField(post),
            ],
          ),
        );
      },
    );
   
  }
   Widget _buildCommentsList(ImageModel post) {
      return Expanded(
        child: ListView.builder(
          itemCount: post.comments.length,
          itemBuilder: (context, index) {
            final comment = post.comments[index];
            return ListTile(
              title: Text(comment.text),
              // Add more details if needed
            );
          },
        ),
      );
    }

    Widget _buildAddCommentTextField(ImageModel post) {
      final TextEditingController _commentController = TextEditingController();

      return Row(
        children: [
          Expanded(
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: 'Add a comment...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              final String commentText = _commentController.text.trim();
              if (commentText.isNotEmpty) {
                postViewModel.addComment(post, commentText);
                _commentController.clear();
              }
            },
          ),
        ],
      );
    }
}
