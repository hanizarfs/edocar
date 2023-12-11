// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:edocar/auth.dart';

// class UserHomePage extends StatelessWidget {
//   UserHomePage({super.key});

//   final User? user = Auth().currentUser;

//   Future<void> signOut() async {
//     await Auth().signOut();
//   }

//   Widget _title() {
//     return const Text('Firebase A');
//   }

//   Widget _userUid() {
//     return Text(user?.email ?? 'User email');
//   }

//   Widget _signOutButton() {
//     return ElevatedButton(
//       onPressed: signOut,
//       child: const Text("Sign Out"),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: _title(),
//       ),
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             _userUid(),
//             _signOutButton(),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edocar/auth.dart';
import 'rental/index.dart';
import 'profile/index.dart';
import 'package:edocar/screens/user/rented/index.dart';

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  int _currentIndex = 0;

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _title() {
    return const Text('Firebase Auth');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: _getPage(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Rented',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return UserHomeTabPage();
      case 1:
        return UserRentedTabPage();
      case 2:
        return UserProfilePage(user: user);
      default:
        return Container();
    }
  }
}

class UserHomeTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: UserRentalList(),
    );
  }
}

class UserRentedTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: RentedTabPage()
          // child: Text('User Rented Tab Page'),
          ),
    );
  }
}
