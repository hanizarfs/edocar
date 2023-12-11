import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddRentalPage extends StatefulWidget {
  @override
  _AddRentalPageState createState() => _AddRentalPageState();
}

class _AddRentalPageState extends State<AddRentalPage> {
  final TextEditingController namaMobilController = TextEditingController();
  final TextEditingController transmisiController = TextEditingController();
  final TextEditingController kapasitasController = TextEditingController();
  final TextEditingController hargaSewaController = TextEditingController();

  Future<void> addRentalToFirebase() async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Include the uuid field from the current user
        await FirebaseFirestore.instance.collection('rentals').add({
          'uuid': user.uid,
          'nama_mobil': namaMobilController.text,
          'transmisi': transmisiController.text,
          'kapasitas': int.parse(kapasitasController.text),
          'harga_sewa': int.parse(hargaSewaController.text),
        });

        // Optionally, you can add a snackbar or navigate to another page after saving
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Rental added successfully!'),
          ),
        );
      } else {
        print('User not logged in.');
        // Handle the case where the user is not logged in
      }
    } catch (e) {
      print('Error adding rental: $e');
      // Handle the error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Rental'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: namaMobilController,
              decoration: InputDecoration(labelText: 'Nama Mobil'),
            ),
            TextFormField(
              controller: transmisiController,
              decoration: InputDecoration(labelText: 'Transmisi'),
            ),
            TextFormField(
              controller: kapasitasController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Kapasitas'),
            ),
            TextFormField(
              controller: hargaSewaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Harga Sewa'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: addRentalToFirebase,
              child: Text('Add Rental'),
            ),
          ],
        ),
      ),
    );
  }
}
