import 'package:flutter/material.dart';
import 'package:socialapp/app/logic/auth_service.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
    AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return   SafeArea(
      // SizedBox(height: 20,)
      child: Align(alignment: Alignment.center,child: ElevatedButton(
                onPressed: _authService.signOut,
                child: Text('Logout'),
              ),));
  }
}