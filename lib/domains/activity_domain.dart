/* 
Activity Model
This is what a activity abject is.

It has these properties:
-id
-address
*/

import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityDomain {
  List<Map<String, dynamic>> roomsStatus;
  Timestamp startTime;
  Timestamp? endTime;
  String overallStatus;
  String id;
  String bookingId;

  ActivityDomain(this.roomsStatus, this.startTime, this.endTime,
      this.overallStatus, this.id, this.bookingId);

  // Constructor with initialization logic
  ActivityDomain.newActivity(this.bookingId)
      : roomsStatus = [
          {'room': "Living Room", 'status': false},
          {'room': "Bedroom", 'status': false},
          {'room': "DiningRoom", 'status': false},
          {'room': "Kitchen", 'status': false},
          {'room': "Bathroom", 'status': false}
        ],
        startTime = Timestamp.now(),
        endTime = null,
        overallStatus = "processing",
        id = "";

  // Constructor for document snapshot
  ActivityDomain.fromDocumentSnapshot(DocumentSnapshot documentSnapshot)
      : roomsStatus = List<Map<String, dynamic>>.from(
            (documentSnapshot.data() as Map<String, dynamic>)['roomsStatus'] ??
                []),
        startTime =
            (documentSnapshot.data() as Map<String, dynamic>)['startTime'] ??
                Timestamp.now(),
        endTime = (documentSnapshot.data() as Map<String, dynamic>)['endTime'],
        overallStatus = (documentSnapshot.data()
                as Map<String, dynamic>)['overallStatus'] ??
            "processing",
        id = documentSnapshot.id,
        bookingId =
            (documentSnapshot.data() as Map<String, dynamic>)['bookingId'] ??
                "";
}
