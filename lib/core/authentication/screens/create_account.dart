import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:socialapp/core/authentication/view_model/auth_view_model.dart';

class UserCreationPage extends StatelessWidget {
  final UserCreationViewModel viewModel = Get.put(UserCreationViewModel());
   final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Creation Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
               controller: emailController,
              onChanged: (value) => viewModel.username.value = value,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
               controller: fullNameController,
              onChanged: (value) => viewModel.fullName.value = value,
              decoration: InputDecoration(
                labelText: 'Full Name',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
               controller: passwordController,
              onChanged: (value) => viewModel.password.value = value,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 24.0),
            Obx(() {
              return ElevatedButton(
                onPressed: viewModel.isLoading() ? null : viewModel.createUser,
                child: viewModel.isLoading() ? CircularProgressIndicator() : Text('Create User'),
              );
            }),
          ],
        ),
      ),
    );
  }
   void _createUser(BuildContext context) {
    // Validate the form before proceeding
    if (_validateForm()) {
      viewModel.createUser();
    }
  }

  bool _validateForm() {
    bool isValid = true;

    // Validate email
    if (emailController.text.isEmpty || !GetUtils.isEmail(emailController.text)) {
      Fluttertoast.showToast(
            msg: "Invalid Email",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
      isValid = false;
    } else {
      return true;
    }

    // Validate full name
    if (fullNameController.text.isEmpty) {
       Fluttertoast.showToast(
            msg: "Full Name cannot be empty",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
      isValid = false;
    } else {
      return true;
    }

    // Validate password
    if (passwordController.text.isEmpty) {
     Fluttertoast.showToast(
            msg: "Password cannot be empty",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
      isValid = false;
    } else {
      return true;
    }

    return isValid;
  }
}