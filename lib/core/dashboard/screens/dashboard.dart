import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialapp/app/logic/user_controller.dart';
import 'package:socialapp/app/presentation/post_widget.dart';
// import 'package:socialapp/core/authentication/view_model/auth_view_model.dart';
import 'package:socialapp/core/posts/model/post_model.dart';
import 'package:socialapp/core/posts/view_model/image_view_model.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // AuthService _authService = AuthService();
  // final LoginViewModel _viewModel = Get.put(LoginViewModel());
  final PostViewModel postViewModel = Get.put(PostViewModel());
  // final FullnameController _fullnameController = FullnameController();
  // final FullnameController _fullnameController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Obx(() {
                      final fullName = Get.find<UserController>().fullName;

                      if (fullName.isNotEmpty) {
                        print('full name is ${fullName}');
                        return Text('Welcome, $fullName');
                      } else {
                        return const Text('Welcome User');
                      }
                    }),
                    SizedBox(
                      height: 20,
                    ),
                    _buildPostWidget(),
                  ],
                ),
              ),
              SizedBox(
                height: 300,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostWidget() {
    return Obx(() {
      final List<ImageModel>? posts = postViewModel.posts?.toList();
      print("Posts here ${posts.toString()}");
      return posts != null && posts.isNotEmpty
          ? PostWidget(posts: posts)
          : const Text(
              'Nothing to display. Posts added would be shown here',
              style: TextStyle(fontSize: 12),
            );
    });
  }
}
