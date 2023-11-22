import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:socialapp/app/logic/auth_service.dart';
import 'package:socialapp/app/logic/user_controller.dart';
import 'package:socialapp/core/authentication/screens/login_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapp/core/dashboard/screens/home.dart';

class UserCreationViewModel extends GetxController {
  // Observable variables
  final AuthService _authService = AuthService();

  var username = ''.obs;
  var fullName = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;

  // Method to handle user creation
  Future<bool> createUser() async {
    try {
      isLoading(true);

      String enteredUsername = username.value.trim();
      String enteredFullName = fullName.value.trim();
      String enteredPassword = password.value.trim();

      UserCredential userCredential = await _authService
          .signUpWithEmailAndPassword(enteredUsername, enteredPassword);
      if (userCredential != null && userCredential.user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({'fullName': enteredFullName});
        username(enteredFullName);
        print('User created successfully');
        Fluttertoast.showToast(
            msg: "User Created Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);

        Get.to(LoginPage());
        return true;
      } else {
        Fluttertoast.showToast(
            msg: "Error Occured while creating User",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
        return false;
      }
    } catch (e) {
      // Handle user creation errors
      print('Error creating user: $e');
      Fluttertoast.showToast(
          msg: 'Error creating user: $e',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
      return false;
    } finally {
      isLoading(false);
    }
  }
}

class LoginViewModel extends GetxController {
  final AuthService _authService = AuthService();
  // final FullnameController _fullnameController = FullnameController();


  // Observable variables
  var username = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;
  var isLoggedIn = false.obs;

  // Method to handle login
  Future<bool> loginUser() async {
    String enteredUsername = username.value.trim();
    String enteredPassword = password.value.trim();

    try {
      isLoading(true);
      UserCredential userCredential = await _authService
          .signInWithEmailAndPassword(enteredUsername, enteredPassword);

      if (userCredential.user != null) {
        print('Successfully Signed in: ${userCredential.user!.uid}');
        User? user = FirebaseAuth.instance.currentUser;
        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get();
        String fullName = documentSnapshot.get('fullName');
        // Get.find<UserCreationViewModel>().fullName(fullName);
        // _fullnameController.fullName; 
        // username(fullName);
         UserController userController = Get.find<UserController>();
      userController.updateFullName(fullName);
        isLoggedIn(true);
        Fluttertoast.showToast(
            msg: "Sign in Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
        print('UID: ${user.uid}');
        print('Full Name: $fullName');
        print('Full Name: $username');

        Get.to(Home());
        return true;
      } else {
        Fluttertoast.showToast(
            msg: "Sign in Failed, try again",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
        return false;
      }
    } catch (e) {
      // Handle the error
      print('Error signing in: $e');
      Fluttertoast.showToast(
          msg: 'Error signing in: $e',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
      // Display an error message to the user or perform other error handling
      return false;
    } finally {
      isLoading(false);
    }
  }
  void updateUsername(String newName) {
    username(newName);
  }
}
