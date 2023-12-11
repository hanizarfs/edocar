import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditRentalPage extends StatefulWidget {
  final String rentalId;

  const EditRentalPage({Key? key, required this.rentalId}) : super(key: key);

  @override
  _EditRentalPageState createState() => _EditRentalPageState();
}

class _EditRentalPageState extends State<EditRentalPage> {
  final TextEditingController namaMobilController = TextEditingController();
  final TextEditingController transmisiController = TextEditingController();
  final TextEditingController kapasitasController = TextEditingController();
  final TextEditingController hargaSewaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load existing rental data
    loadRentalData();
  }

  Future<void> loadRentalData() async {
    try {
      var rentalDocument = await FirebaseFirestore.instance
          .collection('rentals')
          .doc(widget.rentalId)
          .get();
      var rentalData = rentalDocument.data() as Map<String, dynamic>?;

      if (rentalData != null) {
        setState(() {
          namaMobilController.text = rentalData['nama_mobil'] ?? '';
          transmisiController.text = rentalData['transmisi'] ?? '';
          kapasitasController.text = (rentalData['kapasitas'] ?? '').toString();
          hargaSewaController.text =
              (rentalData['harga_sewa'] ?? '').toString();
        });
      }
    } catch (e) {
      print('Error loading rental data: $e');
      // Handle the error as needed
    }
  }

  Future<void> updateRentalData() async {
    try {
      await FirebaseFirestore.instance
          .collection('rentals')
          .doc(widget.rentalId)
          .update({
        'nama_mobil': namaMobilController.text,
        'transmisi': transmisiController.text,
        'kapasitas': int.parse(kapasitasController.text),
        'harga_sewa': int.parse(hargaSewaController.text),
      });

      // Optionally, you can add a snackbar or navigate back after updating
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Rental updated successfully!'),
        ),
      );
    } catch (e) {
      print('Error updating rental: $e');
      // Handle the error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Rental'),
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
              onPressed: updateRentalData,
              child: Text('Update Rental'),
            ),
          ],
        ),
      ),
    );
  }
}
