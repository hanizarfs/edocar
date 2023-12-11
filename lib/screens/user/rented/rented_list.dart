import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RentedList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // Handle the case where the user is not authenticated
      return Container(); // You can customize the handling as needed
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('rental_forms')
          .where('user_id', isEqualTo: user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return Text('No rented items available');
        }

        var rentedForms = snapshot.data!.docs;

        List<Widget> rentedWidgets = [];
        for (var form in rentedForms) {
          var formData = form.data() as Map<String, dynamic>?;

          if (formData != null) {
            rentedWidgets.add(
              ListTile(
                title: Text('Rental ID: ${form.id}'),
                subtitle:
                    Text('Duration: ${formData['duration'] ?? 'N/A'} days'),
                // Add more details as needed
              ),
            );
          }
        }

        return ListView(
          children: rentedWidgets,
        );
      },
    );
  }
}
