import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edocar/auth.dart';
import 'rental_detail.dart'; // Assuming you have a rental detail page

class UserRentalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('rentals').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return Text('No rentals available');
        }

        var rentals = snapshot.data!.docs;

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
                trailing: IconButton(
                  icon: Icon(Icons.info),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RentalDetailPage(rentalId: rental.id),
                      ),
                    );
                  },
                ),
              ),
            );
          }
        }

        return ListView(
          children: rentalWidgets,
        );
      },
    );
  }
}
