import 'package:edocar/screens/admin/rental/add.dart'; // Import your AddRentalPage
import 'package:edocar/screens/admin/rental/edit.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:edocar/auth.dart';

class RentalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Rentals'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('rentals')
            .where('uuid', isEqualTo: Auth().currentUser?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error fetching rentals: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: Text('No rentals available'),
            );
          }

          var rentals = snapshot.data!.docs;

          if (rentals.isEmpty) {
            return Center(
              child: Text('No rentals available'),
            );
          }

          List<Widget> rentalWidgets = [];
          for (var rental in rentals) {
            var rentalData = rental.data() as Map<String, dynamic>?;

            if (rentalData != null) {
              rentalWidgets.add(
                ListTile(
                  title: Text(rentalData['nama_mobil'] ?? ''),
                  subtitle: Text(
                    'Transmisi: ${rentalData['transmisi'] ?? ''}, Kapasitas: ${rentalData['kapasitas'] ?? ''}, Harga Sewa: ${rentalData['harga_sewa'] ?? ''}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditRentalPage(rentalId: rental.id),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // Implement deletion logic here
                          FirebaseFirestore.instance
                              .collection('rentals')
                              .doc(rental.id)
                              .delete();
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
          }

          return ListView(
            children: rentalWidgets,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddRentalPage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
