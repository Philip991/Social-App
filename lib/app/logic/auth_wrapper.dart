import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialapp/app/logic/user_controller.dart';
import 'package:socialapp/core/authentication/screens/login_page.dart';
import 'package:socialapp/core/dashboard/screens/dashboard.dart';
import 'package:socialapp/core/dashboard/screens/home.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      // Check the authentication status
      future: FirebaseAuth.instance.authStateChanges().first,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // If the Future is still running, show a loading indicator
          return Container(
            color: Colors.white,
            width: 50.0, // Adjust the width as needed
            height: 50.0, // Adjust the height as needed
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.hasData) {
            // User is already authenticated, retrieve user information
            User? user = snapshot.data;
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user!.uid)
                  .get(),
              builder: (context, documentSnapshot) {
                if (documentSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  // If the Future is still running, show a loading indicator
                  return Container(
                    color: Colors.white,
                    width: 50.0, // Adjust the width as needed
                    height: 50.0, // Adjust the height as needed
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  // User information retrieved, update controller and navigate to home screen
                  String fullName = documentSnapshot.data!.get('fullName');
                  UserController userController = Get.find<UserController>();
                  userController.updateFullName(fullName);
                  return Home();
                }
              },
            );
          } else {
            // User is not authenticated, navigate to login screen
            return LoginPage();
          }
        }
      },
    );
  }
}
