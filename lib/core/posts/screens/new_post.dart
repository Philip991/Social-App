import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:socialapp/core/dashboard/screens/home.dart';
import 'package:socialapp/core/posts/view_model/image_view_model.dart';

class NewPost extends StatefulWidget {
  const NewPost({super.key});

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  // File? _image;
  final ImageViewModel imageViewModel = Get.put(ImageViewModel());
  final PostViewModel postViewModel = Get.put(PostViewModel());
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      // appBar: AppBar(
      //   // title: const Text('Make a new post'),
      //   centerTitle: true,
      // ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: <Widget>[
                Obx(() {
                  return imageViewModel.imageModel?.imageFile == null
                      ? const Text('No image selected.')
                      : Image.file(imageViewModel.imageModel!.imageFile!);
                }),
                ElevatedButton(
                  onPressed: () => imageViewModel.pickImage(),
                  child: const Text('Pick Image'),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: textEditingController,
                    decoration: const InputDecoration(
                      hintText: 'Enter post text...',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await imageViewModel.uploadImage();
                    // Handle the creation of a new post
                    // ignore: use_build_context_synchronously
                    _createPost(context);
                  },
                  child: const Text('Create Post'),
                ),
                // Obx(() => Text(imageViewModel.uploadMessage)),
              ],
            ),
          ],
        ),
      ),
    ));
    
  }
    void navigateToPageIndex0() {
    Get.offAll(Home(), // Replace with the actual widget for your home page
        transition: Transition.noTransition);
  }

  void _createPost(BuildContext context) {
    // Validate the form before proceeding
    if (_validateForm()) {
      final text = textEditingController.text;
                    final imageFile = imageViewModel.imageModel?.imageFile;
                    final imageUrl = imageViewModel.imageModel?.imageUrl;
                    postViewModel.addPost(text, imageFile,imageUrl );
                    Fluttertoast.showToast(
                        msg: "Post Made Successfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity
                            .BOTTOM);
                           navigateToPageIndex0(); 
    }
  }

  bool _validateForm() {
    bool isValid = true;


    // Validate password
    if (textEditingController.text.isEmpty) {
      Fluttertoast.showToast(
            msg: "Text cannot be empty",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
      isValid = false;
    } else {
      return true;
    }

    return isValid;
  }
  
}

