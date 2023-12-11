import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:edocar/auth.dart';

class UserProfilePage extends StatelessWidget {
  final User? user;

  UserProfilePage({required this.user});

  Widget _userUid() {
    return Text('User Email: ${user?.email ?? 'N/A'}');
  }

  Widget _signOutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Auth().signOut();
        Navigator.pop(context); // Pop the profile page after signing out
      },
      child: Text('Sign Out'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _userUid(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement any profile-related actions
              },
              child: Text('Edit Profile'),
            ),
            _signOutButton(context),
          ],
        ),
      ),
    );
  }
}
