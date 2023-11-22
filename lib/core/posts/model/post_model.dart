import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageModel{
  String text;
  File? imageFile;
  String? imageUrl;
  RxInt likes = 0.obs;
  RxList<CommentModel> comments = <CommentModel>[].obs;


  ImageModel({this.imageFile, required this.text, this.imageUrl});
  
  @override
  String toString() {
    return 'ImageModel{text: $text, imageFile: $imageFile, imageUrl: $imageUrl, likes: $likes, comments: $comments}';
  }
}

class CommentModel {
  String text;

  CommentModel({required this.text});
}