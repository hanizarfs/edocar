// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class RentalDetailPage extends StatelessWidget {
//   final String rentalId;

//   RentalDetailPage({required this.rentalId});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Rental Detail'),
//       ),
//       body: FutureBuilder<DocumentSnapshot>(
//         future: FirebaseFirestore.instance
//             .collection('rentals')
//             .doc(rentalId)
//             .get(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator();
//           }

//           if (!snapshot.hasData || snapshot.data == null) {
//             return Text('Rental not found');
//           }

//           var rentalData = snapshot.data!.data() as Map<String, dynamic>?;

//           if (rentalData == null) {
//             return Text('Invalid rental data');
//           }

//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Nama Mobil: ${rentalData['nama_mobil'] ?? 'N/A'}'),
//                 Text('Transmisi: ${rentalData['transmisi'] ?? 'N/A'}'),
//                 Text('Kapasitas: ${rentalData['kapasitas'] ?? 'N/A'}'),
//                 Text('Harga Sewa: ${rentalData['harga_sewa'] ?? 'N/A'}'),
//                 // Add more details as needed
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'rental_form.dart'; // Import the rental form page

class RentalDetailPage extends StatelessWidget {
  final String rentalId;

  RentalDetailPage({required this.rentalId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rental Detail'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('rentals')
            .doc(rentalId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Text('Rental not found');
          }

          var rentalData = snapshot.data!.data() as Map<String, dynamic>?;

          if (rentalData == null) {
            return Text('Invalid rental data');
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nama Mobil: ${rentalData['nama_mobil'] ?? 'N/A'}'),
                Text('Transmisi: ${rentalData['transmisi'] ?? 'N/A'}'),
                Text('Kapasitas: ${rentalData['kapasitas'] ?? 'N/A'}'),
                Text('Harga Sewa: ${rentalData['harga_sewa'] ?? 'N/A'}'),
                // Add more details as needed

                SizedBox(height: 16),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RentalFormPage(rentalId: rentalId),
                      ),
                    );
                  },
                  child: Text('Rental Now'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
