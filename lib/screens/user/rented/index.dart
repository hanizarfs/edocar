import 'package:flutter/material.dart';
import 'rented_list.dart'; // Import your RentedList widget

class RentedTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rented Tab Page'),
      ),
      body: RentedList(), // Use your RentedList widget here
    );
  }
}
