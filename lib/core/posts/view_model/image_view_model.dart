import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialapp/app/logic/firebase_image_service.dart';
import 'package:socialapp/core/posts/model/post_model.dart';
import 'package:socialapp/core/posts/view_model/image_picker.dart';

class ImageViewModel extends GetxController{
  Rx<ImageModel?> _imageModel = Rx<ImageModel?>(null);
  RxString _uploadMessage = ''.obs;

  ImageModel? get imageModel => _imageModel.value;
  String get uploadMessage => _uploadMessage.value;

  Future<void> pickImage() async {
    final imageFile = await ImagePickerService.pickImage();
    if (imageFile != null) {
      _imageModel.value = ImageModel(imageFile: imageFile, text: '');
      _uploadMessage.value = '';
    }
  }

  Future<void> uploadImage() async {
    if (_imageModel.value?.imageFile == null) {
      _uploadMessage.value = 'No image selected.';
      return;
    }

    _uploadMessage.value = 'Uploading...';

    try {
      final message = await FirebaseService.uploadImage(_imageModel.value!.imageFile!);
      _uploadMessage.value = message;
    } catch (e) {
      _uploadMessage.value = 'Error uploading image.';
      print(e.toString());
    }
  }
}

class PostViewModel extends GetxController{
  RxList<ImageModel> _posts = <ImageModel>[].obs;

  List<ImageModel> get posts => _posts;

  void addPost(String text, File? imageFile, String? imageUrl) {
    final newPost = ImageModel(text: text, imageFile: imageFile, imageUrl: imageUrl);
    _posts.insert(0, newPost);
    print("New post added: $newPost");
    print("Updated posts: $_posts");
  }
  
  void likePost(ImageModel post) {
    post.likes++;
  }

  void addComment(ImageModel post, String commentText) {
    final newComment = CommentModel(text: commentText);
    post.comments.add(newComment);
  }
}