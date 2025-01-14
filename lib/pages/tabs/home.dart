import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _addressController = TextEditingController();

  /* void openDialog({String? docID}) {
    Get.defaultDialog(
      title: "Add new booking",
      content: Column(
        children: [
          TextField(
            controller: _addressController,
            decoration: const InputDecoration(labelText: "Address"),
          ),
          ElevatedButton(
            onPressed: () {
              if (docID != null) {
                // Add booking
                BookingProvider().updateBooking(
                    docID,
                    Booking(
                      address: _addressController.text,
                    ));
                Get.back();
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  } */

  @override
  Widget build(BuildContext context) {
    return Text("Home Page");
    /* Center(
      child: StreamBuilder(
          stream: BookingProvider().getBookingsStream(),
          builder: (context, snapshot) {
            // If we have data, get all the docs
            if (snapshot.hasData) {
              List bookingsList = snapshot.data!.docs;

              // Display as a list
              return ListView.builder(
                itemCount: bookingsList.length,
                itemBuilder: (context, index) {
                  // Get each individual doc
                  DocumentSnapshot document = bookingsList[index];
                  String docID = document.id;

                  // Get booking from each doc
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String addressText = data['address'];

                  // Display as a list tile
                  return ListTile(
                    title: Text(index.toString()),
                    subtitle: Text(addressText),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Update booking
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => openDialog(docID: docID),
                        ),
                        // Delete booking
                        IconButton(
                            onPressed: () =>
                                BookingProvider().deleteBooking(docID),
                            icon: const Icon(Icons.delete))
                      ],
                    ),
                  );
                },
              );
            } else {
              // If no data, return nothing
              return const Text("No bookings...");
            }
          }),
    ); */
  }
}
