// // // import 'package:flutter/material.dart';
// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:edocar/auth.dart';
// // // import 'rental/add.dart';
// // // import 'rental/edit.dart';

// // // class AdminHomePage extends StatelessWidget {
// // //   AdminHomePage({super.key});

// // //   final User? user = Auth().currentUser;

// // //   Future<void> signOut() async {
// // //     await Auth().signOut();
// // //   }

// // //   Widget _title() {
// // //     return const Text('Firebase Auth');
// // //   }

// // //   Widget _userUid() {
// // //     return Text(user?.email ?? 'User email');
// // //   }

// // //   Widget _signOutButton() {
// // //     return ElevatedButton(
// // //       onPressed: signOut,
// // //       child: const Text("Sign Out"),
// // //     );
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: _title(),
// // //       ),
// // //       body: Container(
// // //         height: double.infinity,
// // //         width: double.infinity,
// // //         padding: const EdgeInsets.all(20),
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.center,
// // //           mainAxisAlignment: MainAxisAlignment.center,
// // //           children: <Widget>[
// // //             InkWell(
// // //               onTap: () {
// // //                 Navigator.push(
// // //                   context,
// // //                   MaterialPageRoute(
// // //                     builder: (context) => AddRentalPage(),
// // //                   ),
// // //                 );
// // //               },
// // //               child: Row(
// // //                 children: [
// // //                   Icon(Icons.add),
// // //                   SizedBox(width: 8),
// // //                   Text('Add Rental'),
// // //                 ],
// // //               ),
// // //             ),
// // //             SizedBox(height: 20),
// // //             Text('All Rentals:'),
// // Expanded(
// //   child: RentalList(),
// // ),
// // // _userUid(),
// // // _signOutButton(),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:edocar/auth.dart';
// // import 'rental/add.dart';
// // import 'rental/edit.dart';

// // class AdminHomePage extends StatefulWidget {
// //   @override
// //   _AdminHomePageState createState() => _AdminHomePageState();
// // }

// // class _AdminHomePageState extends State<AdminHomePage> {
// //   int _currentIndex = 0;

// //   final User? user = Auth().currentUser;

// //   Future<void> signOut() async {
// //     await Auth().signOut();
// //   }

// //   Widget _title() {
// //     return const Text('Firebase Auth');
// //   }

// //   Widget _userUid() {
// //     return Text(user?.email ?? 'User email');
// //   }

// //   Widget _signOutButton() {
// //     return ElevatedButton(
// //       onPressed: signOut,
// //       child: const Text("Sign Out"),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: _title(),
// //       ),
// //       body: _getPage(_currentIndex),
// //       bottomNavigationBar: BottomNavigationBar(
// //         currentIndex: _currentIndex,
// //         onTap: (index) {
// //           setState(() {
// //             _currentIndex = index;
// //           });
// //         },
// //         items: [
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.add),
// //             label: 'Add Rental',
// //           ),
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.list),
// //             label: 'All Rentals',
// //           ),
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.person),
// //             label: 'Profile',
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _getPage(int index) {
// //     switch (index) {
// //       case 0:
// //         return AddRentalPage();
// //       case 1:
// //         return RentalList();
// //       case 2:
// //         return UserProfilePage(user: user);
// //       default:
// //         return Container();
// //     }
// //   }
// // }

// // class UserProfilePage extends StatelessWidget {
// //   final User? user;

// //   UserProfilePage({required this.user});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       mainAxisAlignment: MainAxisAlignment.center,
// //       children: [
// //         Text('User Profile Page'),
// //         SizedBox(height: 20),
// //         Text('User Email: ${user?.email ?? 'N/A'}'),
// //         ElevatedButton(
// //           onPressed: () {
// //             // Implement any profile-related actions
// //           },
// //           child: Text('Edit Profile'),
// //         ),
// //       ],
// //     );
// //   }
// // }

// // class RentalList extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return StreamBuilder<QuerySnapshot>(
// //       stream: FirebaseFirestore.instance
// //           .collection('rentals')
// //           .where('uuid', isEqualTo: Auth().currentUser?.uid)
// //           .snapshots(),
// //       builder: (context, snapshot) {
// //         if (snapshot.connectionState == ConnectionState.waiting) {
// //           return CircularProgressIndicator();
// //         }

// //         if (!snapshot.hasData || snapshot.data == null) {
// //           return Text('No rentals available');
// //         }

// //         var rentals = snapshot.data!.docs;

// //         List<Widget> rentalWidgets = [];
// //         for (var rental in rentals) {
// //           var rentalData = rental.data() as Map<String, dynamic>?;

// //           if (rentalData != null) {
// //             rentalWidgets.add(
// //               ListTile(
// //                 title: Text(rentalData['nama_mobil'] ?? ''),
// //                 subtitle: Text(
// //                   'Transmisi: ${rentalData['transmisi'] ?? ''}, Kapasitas: ${rentalData['kapasitas'] ?? ''}, Harga Sewa: ${rentalData['harga_sewa'] ?? ''}',
// //                 ),
// //                 trailing: Row(
// //                   mainAxisSize: MainAxisSize.min,
// //                   children: [
// //                     IconButton(
// //                       icon: Icon(Icons.edit),
// //                       onPressed: () {
// //                         Navigator.push(
// //                           context,
// //                           MaterialPageRoute(
// //                             builder: (context) =>
// //                                 EditRentalPage(rentalId: rental.id),
// //                           ),
// //                         );
// //                       },
// //                     ),
// //                     IconButton(
// //                       icon: Icon(Icons.delete),
// //                       onPressed: () {
// //                         // Implement deletion logic here
// //                         FirebaseFirestore.instance
// //                             .collection('rentals')
// //                             .doc(rental.id)
// //                             .delete();
// //                       },
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             );
// //           }
// //         }

// //         return ListView(
// //           children: rentalWidgets,
// //         );
// //       },
// //     );
// //   }
// // }

// // // class RentalList extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return StreamBuilder<QuerySnapshot>(
// // //       stream: FirebaseFirestore.instance.collection('rentals').snapshots(),
// // //       builder: (context, snapshot) {
// // //         if (snapshot.connectionState == ConnectionState.waiting) {
// // //           return CircularProgressIndicator();
// // //         }

// // //         if (!snapshot.hasData || snapshot.data == null) {
// // //           return Text('No rentals available');
// // //         }

// // //         var rentals = snapshot.data!.docs;

// // //         List<Widget> rentalWidgets = [];
// // //         for (var rental in rentals) {
// // //           var rentalData = rental.data() as Map<String, dynamic>?;

// // //           if (rentalData != null) {
// // //             rentalWidgets.add(
// // //               ListTile(
// // //                 title: Text(rentalData['nama_mobil'] ?? ''),
// // //                 subtitle: Text(
// // //                   'Transmisi: ${rentalData['transmisi'] ?? ''}, Kapasitas: ${rentalData['kapasitas'] ?? ''}, Harga Sewa: ${rentalData['harga_sewa'] ?? ''}',
// // //                 ),
// // //                 trailing: Row(
// // //                   mainAxisSize: MainAxisSize.min,
// // //                   children: [
// // //                     IconButton(
// // //                       icon: Icon(Icons.edit),
// // //                       onPressed: () {
// // //                         Navigator.push(
// // //                           context,
// // //                           MaterialPageRoute(
// // //                             builder: (context) =>
// // //                                 EditRentalPage(rentalId: rental.id),
// // //                           ),
// // //                         );
// // //                       },
// // //                     ),
// // //                     IconButton(
// // //                       icon: Icon(Icons.delete),
// // //                       onPressed: () {
// // //                         // Implement deletion logic here
// // //                         FirebaseFirestore.instance
// // //                             .collection('rentals')
// // //                             .doc(rental.id)
// // //                             .delete();
// // //                       },
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             );
// // //           }
// // //         }

// // //         return ListView(
// // //           children: rentalWidgets,
// // //         );
// // //       },
// // //     );
// // //   }
// // // }

// import 'package:edocar/screens/admin/rental/index.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:edocar/auth.dart';
// import 'rental/add.dart';
// import 'rental/edit.dart';

// class AdminHomePage extends StatefulWidget {
//   @override
//   _AdminHomePageState createState() => _AdminHomePageState();
// }

// class _AdminHomePageState extends State<AdminHomePage> {
//   int _currentIndex = 0;

//   final User? user = Auth().currentUser;

//   Future<void> signOut() async {
//     await Auth().signOut();
//   }

//   Widget _title() {
//     return const Text('Firebase Auth');
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
//       body: _getPage(_currentIndex),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.list),
//             label: 'Rented',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _getPage(int index) {
//     switch (index) {
//       case 0:
//         return HomeTabPage();
//       case 1:
//         return RentedTabPage();
//       case 2:
//         return UserProfilePage(user: user);
//       default:
//         return Container();
//     }
//   }
// }

// class UserProfilePage extends StatelessWidget {
//   final User? user;

//   UserProfilePage({required this.user});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text('User Profile Page'),
//         SizedBox(height: 20),
//         Text('User Email: ${user?.email ?? 'N/A'}'),
//         ElevatedButton(
//           onPressed: () {},
//           child: Text('Edit Profile'),
//           _userUid(),
//           _signOutButton(),
//         ),
//       ],
//     );
//   }
// }

// class HomeTabPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(16.0),
//         child: RentalList(), // Use the RentalList widget here
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => AddRentalPage(),
//             ),
//           );
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

// class RentedTabPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Center(
//         child: Text('Rented Tab Page'),
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

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
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
        return HomeTabPage();
      case 1:
        return RentedTabPage();
      case 2:
        return UserProfilePage(user: user);
      default:
        return Container();
    }
  }
}

class HomeTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: RentalList(),
    );
  }
}

class RentedTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Rented Tab Page'),
      ),
    );
  }
}
