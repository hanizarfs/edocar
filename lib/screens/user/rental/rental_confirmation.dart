// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class RentalConfirmationPage extends StatelessWidget {
//   final String rentalId;
//   final String duration;

//   RentalConfirmationPage({required this.rentalId, required this.duration});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Confirmation'),
//       ),
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: fetchData(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }

//           final Map<String, dynamic> data = snapshot.data ?? {};

//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Rental ID: $rentalId'),
//                 Text('Car Name: ${data['nama_mobil'] ?? 'N/A'}'),
//                 Text('Transmission: ${data['transmisi'] ?? 'N/A'}'),
//                 Text('Capacity: ${data['kapasitas'] ?? 'N/A'}'),
//                 Text('Rental Duration: $duration days'),
//                 SizedBox(height: 16),
//                 Text(
//                   'Total Price: \$${data['harga_sewa']?.toStringAsFixed(2) ?? 'N/A'}',
//                 ),
//                 SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Add logic to proceed with rental submission
//                     Navigator.popUntil(
//                         context, ModalRoute.withName('/user/home'));
//                   },
//                   child: Text('Rent Now'),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Future<Map<String, dynamic>> fetchData() async {
//     try {
//       final Map<String, dynamic> result = {};

//       // Fetch rental details from the rentals collection
//       DocumentSnapshot rentalSnapshot = await FirebaseFirestore.instance
//           .collection('rentals')
//           .doc(rentalId)
//           .get();

//       if (rentalSnapshot.exists) {
//         result.addAll(rentalSnapshot.data() as Map<String, dynamic>);

//         // Fetch additional details from the rental_forms collection
//         DocumentSnapshot formSnapshot = await FirebaseFirestore.instance
//             .collection('rental_forms')
//             .doc(rentalId)
//             .get();

//         if (formSnapshot.exists) {
//           result.addAll(formSnapshot.data() as Map<String, dynamic>);

//           // Calculate total price (assuming the total price is stored in the rental document)
//           // If the total price is not directly available, you might need to adjust this logic
//           // based on your actual data structure
//           double hargaSewa = result['harga_sewa'] ?? 0;
//           int rentalDuration = int.parse(duration);
//           result['totalPrice'] = hargaSewa * rentalDuration;
//         } else {
//           // Handle the case where the form document doesn't exist
//           print('Rental form not found in the database');
//         }
//       } else {
//         // Handle the case where the rental document doesn't exist
//         print('Rental not found in the database');
//       }

//       return result;
//     } catch (e) {
//       // Handle errors
//       print('Error fetching data: $e');
//       return {};
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RentalConfirmationPage extends StatelessWidget {
  final String rentalId;
  final String duration;

  RentalConfirmationPage({required this.rentalId, required this.duration});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmation'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final Map<String, dynamic> data = snapshot.data ?? {};

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rental ID: $rentalId'),
                Text('Car Name: ${data['carName'] ?? 'N/A'}'),
                Text('Transmission: ${data['transmisi'] ?? 'N/A'}'),
                Text('Capacity: ${data['kapasitas'] ?? 'N/A'}'),
                Text('Rental Duration: $duration days'),
                SizedBox(height: 16),
                Text(
                  'Total Price: \$${data['harga_sewa']?.toStringAsFixed(2) ?? 'N/A'}',
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Add logic to proceed with rental submission
                    Navigator.popUntil(
                        context, ModalRoute.withName('/user/home'));
                  },
                  child: Text('Rent Now'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<Map<String, dynamic>> fetchData() async {
    try {
      final Map<String, dynamic> result = {};

      // Fetch rental details from the rentals collection
      DocumentSnapshot rentalSnapshot = await FirebaseFirestore.instance
          .collection('rentals')
          .doc(rentalId)
          .get();

      if (rentalSnapshot.exists) {
        result.addAll(rentalSnapshot.data() as Map<String, dynamic>);

        // Fetch additional details from the rental_forms collection
        DocumentSnapshot formSnapshot = await FirebaseFirestore.instance
            .collection('rental_forms')
            .doc(rentalId)
            .get();

        if (formSnapshot.exists) {
          result.addAll(formSnapshot.data() as Map<String, dynamic>);

          // Fetch car details from the mobil collection
          DocumentSnapshot carSnapshot = await FirebaseFirestore.instance
              .collection('mobil')
              .doc(result['mobil_id'])
              .get();

          if (carSnapshot.exists) {
            result['carName'] = carSnapshot['nama_mobil'];
          } else {
            // Handle the case where the car document doesn't exist
            print('Car not found in the database');
          }

          // Calculate total price (assuming the total price is stored in the rental document)
          // If the total price is not directly available, you might need to adjust this logic
          // based on your actual data structure
          double hargaSewa = result['harga_sewa'] ?? 0;
          int rentalDuration = int.parse(duration);
          result['totalPrice'] = hargaSewa * rentalDuration;
        } else {
          // Handle the case where the form document doesn't exist
          print('Rental form not found in the database');
        }
      } else {
        // Handle the case where the rental document doesn't exist
        print('Rental not found in the database');
      }

      return result;
    } catch (e) {
      // Handle errors
      print('Error fetching data: $e');
      return {};
    }
  }
}
