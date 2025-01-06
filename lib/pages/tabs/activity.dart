import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../providers/booking_provider.dart';
import '../../providers/activity_provider.dart';

class ActivityPage extends StatelessWidget {
  ActivityPage({super.key}) {
    // Load booking data
    loadBookingData();
  }

  final BookingProvider bookingProvider = Get.find<BookingProvider>();
  final ActivityProvider activityProvider = Get.find<ActivityProvider>();

  Future<void> loadBookingData() async {
    // Ensure booking data is loaded
    await bookingProvider.getAllNotCompletedBookings();
  }

  Future<List<Widget>> _initBookingList() async {
    var listTileList =
        await Future.wait(bookingProvider.bookingList.map((value) async {
      String bookingId = value["id"];
      String bookingAddress = value["address"];
      // Check if activity exists for the bookingId
      bool activityExists =
          await activityProvider.checkActivityExists(bookingId);

      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5.0,
        color: activityExists ? Colors.blue[100] : null,
        margin: EdgeInsets.all(10.0),
        child: ListTile(
          contentPadding: EdgeInsets.all(10.0),
          title: Text(bookingId),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          subtitle: Text(bookingAddress),
          trailing: activityExists
              ? Text(
                  "Processing",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : null,
          onTap: () {
            Get.defaultDialog(
              title: "Start Activity for $bookingId",
              middleText: "Confirm to start?",
              confirm: ElevatedButton(
                onPressed: () async {
                  if (!activityExists) {
                    // Create a new activity if it doesn't exist
                    await activityProvider.addActivity(bookingId);
                  }

                  // Navigate to the update status page
                  Get.offNamed("/updatestatus", arguments: {
                    "title": "I am update status page",
                    "id": bookingId,
                    "address": bookingAddress,
                  });
                },
                child: Text("Confirm"),
              ),
              cancel: ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("Cancel"),
              ),
            );
          },
        ),
      );
    }));

    return listTileList.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      loadBookingData();
      return Center(
          child: FutureBuilder(
              future: _initBookingList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children: snapshot.data ?? [],
                  );
                } else {
                  return Text("No data available");
                }
              }));
    });
  }
}
