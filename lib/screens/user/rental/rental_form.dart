// import 'package:edocar/screens/user/home.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class RentalFormPage extends StatefulWidget {
//   final String rentalId;

//   RentalFormPage({required this.rentalId});

//   @override
//   _RentalFormPageState createState() => _RentalFormPageState();
// }

// class _RentalFormPageState extends State<RentalFormPage> {
//   final TextEditingController _durationController = TextEditingController();

//   Future<void> _submitRentalForm() async {
//     final User? user = FirebaseAuth.instance.currentUser;

//     if (user == null) {
//       // Handle the case where the user is not authenticated
//       return;
//     }

//     final String userId = user.uid;
//     final String rentalId = widget.rentalId;
//     final String duration = _durationController.text.trim();

//     if (duration.isEmpty) {
//       // Handle the case where the duration is not provided
//       return;
//     }

//     try {
//       await FirebaseFirestore.instance.collection('rental_forms').add({
//         'user_id': userId,
//         'rental_id': rentalId,
//         'duration': duration,
//         'timestamp': FieldValue.serverTimestamp(),
//       });

//       // Handle successful submission
//       // Navigate to the 'RentedTabPage' and remove the current page from the stack
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(
//           builder: (context) => UserRentedTabPage(),
//         ),
//         (route) => false,
//       );
//     } catch (e) {
//       // Handle the error
//       print('Error submitting rental form: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Rental Form'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Rental Duration (in days):'),
//             TextFormField(
//               controller: _durationController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 hintText: 'Enter duration',
//               ),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _submitRentalForm,
//               child: Text('Submit Rental Form'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'rental_confirmation.dart'; // Import the confirmation page

class RentalFormPage extends StatefulWidget {
  final String rentalId;

  RentalFormPage({required this.rentalId});

  @override
  _RentalFormPageState createState() => _RentalFormPageState();
}

class _RentalFormPageState extends State<RentalFormPage> {
  final TextEditingController _durationController = TextEditingController();

  Future<void> _submitRentalForm() async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // Handle the case where the user is not authenticated
      return;
    }

    final String userId = user.uid;
    final String rentalId = widget.rentalId;
    final String duration = _durationController.text.trim();

    if (duration.isEmpty) {
      // Handle the case where the duration is not provided
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('rental_forms').add({
        'user_id': userId,
        'rental_id': rentalId,
        'duration': duration,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Navigate to the confirmation page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RentalConfirmationPage(
            rentalId: rentalId,
            duration: duration,
          ),
        ),
      );
    } catch (e) {
      // Handle the error
      print('Error submitting rental form: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rental Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Rental Duration (in days):'),
            TextFormField(
              controller: _durationController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter duration',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitRentalForm,
              child: Text('Submit Rental Form'),
            ),
          ],
        ),
      ),
    );
  }
}
