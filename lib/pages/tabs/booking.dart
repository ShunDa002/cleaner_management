import 'package:flutter/material.dart';

import '../../providers/booking_provider.dart';
import '../../domains/booking_domain.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  // Text controller
  final TextEditingController addressTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // Add new booking
          Padding(
            padding: EdgeInsets.all(10),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text("Add New Booking"),
                    TextField(
                      controller: addressTextController,
                      decoration: InputDecoration(labelText: "Address"),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                // Add new booking
                BookingProvider().addBooking(addressTextController.text);

                // Clear text field
                addressTextController.clear();
              },
              child: Text("Add"))
        ],
      ),
    );
  }
}
