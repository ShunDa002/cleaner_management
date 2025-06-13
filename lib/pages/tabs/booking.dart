import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../providers/booking_provider.dart';
import '../../providers/user_provider.dart';

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
    final BookingProvider bookingProvider = Get.find<BookingProvider>();

    final UserProvider userProvider = Get.find<UserProvider>();

    return GetX<UserProvider>(builder: (userProvider) {
      if (userProvider.userLogin.role == "owner") {
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
                    bookingProvider.addBooking(addressTextController.text);

                    // Clear text field
                    addressTextController.clear();
                  },
                  child: Text("Add"))
            ],
          ),
        );
      } else {
        return Center(
          child: Text("Only valid for Owner"),
        );
      }
    });
  }
}
