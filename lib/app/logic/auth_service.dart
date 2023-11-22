import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:socialapp/core/authentication/screens/login_page.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

    var isLoggedIn = false.obs;

  // Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      // Handle authentication errors
      print(e.toString());
      throw Exception('Failed to sign in: $e');
    }
  }

  Future<UserCredential> signUpWithEmailAndPassword(String email, String password) async {
    try{
      return await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password,
        );
    }catch(e){
      print('Error signing up: $e');
      throw Exception('Failed to sign up: $e');
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
    Fluttertoast.showToast(
            msg: "Logging Out",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
            isLoggedIn(false);
    Get.to(LoginPage());
  }
}