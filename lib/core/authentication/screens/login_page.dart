import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:socialapp/core/authentication/screens/create_account.dart';
import 'package:socialapp/core/authentication/view_model/auth_view_model.dart';

class LoginPage extends StatelessWidget {
  final LoginViewModel viewModel = Get.put(LoginViewModel());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        automaticallyImplyLeading: true
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
              controller: passwordController,
              onChanged: (value) => viewModel.password.value = value,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap:(){Get.to(UserCreationPage());},
              child: const Text(
              "Not a registered user?, create an account here",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10),
            ),
            ),
            SizedBox(height: 24.0),
            Obx(() {
              return ElevatedButton(
                onPressed: viewModel.isLoading() ? null : () => _loginUser(context),
                child: viewModel.isLoading() ? CircularProgressIndicator() : Text('login'),
              );
            }),
          ],
        ),
      ),
    );
  }
  void _loginUser(BuildContext context) {
    // Validate the form before proceeding
    if (_validateForm()) {
      viewModel.loginUser();
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


