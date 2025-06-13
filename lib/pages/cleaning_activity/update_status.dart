import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../providers/activity_provider.dart';

class UpdateStatusPage extends StatelessWidget {
  UpdateStatusPage({super.key});

  final ActivityProvider activityProvider = Get.find<ActivityProvider>();

  @override
  Widget build(BuildContext context) {
    String bookingId = Get.arguments["id"];
    String bookingAddress = Get.arguments["address"];

    // Fetch activity by ID during initialization
    activityProvider.getActivityByBookingId(bookingId);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Activity Status"),
      ),
      body: Obx(() {
        // Calculate room cleaning progress
        activityProvider.calculateProgress(bookingId);
        if (activityProvider.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (activityProvider.loadedActivity.value == null) {
          return Center(child: Text("No data found"));
        } else {
          var loadedActivity = activityProvider.loadedActivity.value!;
          return Center(
              child: Column(children: [
            // House detail
            Expanded(
                flex: 1,
                child: Container(
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.all(20.0),
                    height: 80,
                    decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(bookingId),
                        Divider(),
                        Text(bookingAddress),
                      ],
                    ))),
            // Room status list tile
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(8.0),
                margin: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(5.0)),
                child: ListView.builder(
                  itemCount: loadedActivity.roomsStatus.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Checkbox(
                        value: loadedActivity.roomsStatus[index]['status'],
                        onChanged: (newValue) {
                          print(
                              "${loadedActivity.roomsStatus[index]['room']} is ${newValue}");

                          // Update room status in db
                          activityProvider.updateActivity(
                            newValue: newValue, // New room status
                            roomIndex: index, // Index of the room
                            activityId: loadedActivity.id, // ID of the activity
                          );
                        },
                      ),
                      title: Text(
                        loadedActivity.roomsStatus[index]['room'],
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Text(
                  "${activityProvider.progress.value.toStringAsFixed(2)}%",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                )),
            // Completed button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              onPressed: () {
                if (activityProvider.progress.value >= 100) {
                  // Update overall status in Firestore
                  activityProvider.updateActivity(
                    statusOverall: "completed",
                    activityId: loadedActivity.id,
                  );

                  Get.back();
                } else {
                  Get.snackbar("Error", "Please complete all rooms.");
                }
              },
              child: const Text("Mark as Completed"),
            ),
          ]));
        }
      }),
    );
  }
}










/* class UpdateStatusPage extends StatefulWidget {
  const UpdateStatusPage({super.key});

  @override
  State<UpdateStatusPage> createState() => _UpdateStatusPageState();
}

class _UpdateStatusPageState extends State<UpdateStatusPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(Get.arguments);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Activity Status"),
      ),
      body: Center(
        child: Column(
          children: [
            // House detail
            Expanded(
                flex: 1,
                child: Container(
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.all(20.0),
                    height: 80,
                    decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Update Status Page"),
                        Divider(),
                        Text("ID: 1"),
                      ],
                    ))),
            // Room status list tile
            Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(5.0)),
                  child: ListView.builder(
                    itemCount: _room.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Checkbox(
                            value: true,
                            onChanged: (value) {
                              print("${_room[index]["room"]} is false");
                            }),
                        title: Text(
                          _room[index]["room"],
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
                ))
          ],
        ),
      ),
      // Bottom completed button
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.blue),
            ),
            onPressed: () {
              Get.back();
            },
            child: Text("Completed"),
          ),
        ),
      ),
    );
  }
}
 */