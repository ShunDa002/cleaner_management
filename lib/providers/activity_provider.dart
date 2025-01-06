import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../domains/activity_domain.dart';

class ActivityProvider extends GetxController {
  var isLoading = true.obs;
  var loadedActivity = Rxn<ActivityDomain>();
  var progress = 0.0.obs;

  // Fetch activities from Firestore
  final CollectionReference activitiesCollection =
      FirebaseFirestore.instance.collection('activities');

// Calculate room cleaned progress percentage
  Future<void> calculateProgress(String bookingId) async {
    try {
      // Fetch the activity document from Firestore
      QuerySnapshot querySnapshot = await activitiesCollection
          .where('bookingId', isEqualTo: bookingId)
          .get();

      if (querySnapshot.docs.isEmpty) {
        throw Exception("No activity found for bookingId $bookingId.");
      }

      // Get the first matching document
      DocumentSnapshot activitySnapshot = querySnapshot.docs.first;

      // Extract roomsStatus from the document
      List<Map<String, dynamic>> roomsStatus = List<Map<String, dynamic>>.from(
        activitySnapshot['roomsStatus'],
      );

      // Calculate progress
      int totalRooms = roomsStatus.length;
      int cleanedRooms =
          roomsStatus.where((room) => room['status'] == true).length;
      progress.value = (cleanedRooms / totalRooms) * 100;
    } catch (error) {
      print("Error calculating progress: $error");
    }
  }

// Check if an activity exists for a given bookingId
  Future<bool> checkActivityExists(String bookingId) async {
    try {
      QuerySnapshot querySnapshot = await activitiesCollection
          .where('bookingId', isEqualTo: bookingId)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (error) {
      print("Error checking activity existence: $error");
      Get.snackbar("Error", "Failed to check activity existence.");
      return false;
    }
  }

// Get activity by bookingId
  Future<void> getActivityByBookingId(String bookingId) async {
    try {
      isLoading.value = true;

      const int maxRetries = 10; // Maximum number of attempts
      const Duration delayBetweenRetries =
          Duration(seconds: 1); // Delay between retries

      DocumentSnapshot? activitySnapshot;
      for (int attempt = 0; attempt < maxRetries; attempt++) {
        QuerySnapshot querySnapshot = await activitiesCollection
            .where('bookingId', isEqualTo: bookingId)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          activitySnapshot = querySnapshot.docs.first;
          break;
        }

        // Wait for the next attempt
        await Future.delayed(delayBetweenRetries);
      }

      if (activitySnapshot == null) {
        throw Exception(
            "No activity found for bookingId $bookingId after $maxRetries attempts.");
      }

      // Create an instance of Activity using the data from the snapshot
      ActivityDomain activity = ActivityDomain(
        List<Map<String, dynamic>>.from(activitySnapshot['roomsStatus']),
        activitySnapshot['startTime'],
        activitySnapshot['endTime'],
        activitySnapshot['overallStatus'],
        activitySnapshot.id,
        activitySnapshot['bookingId'],
      );

      loadedActivity.value = activity;
    } catch (error) {
      print("Error fetching activity: $error");
      Get.snackbar("Error", "$error");
      loadedActivity.value = null;
    } finally {
      isLoading.value = false;
    }
  }

// Add new activity
  Future<void> addActivity(String bookingId) async {
    try {
      // Create a new activity instance
      ActivityDomain newActivity = ActivityDomain.newActivity(bookingId);

      // Add the new activity to Firestore
      await activitiesCollection.add({
        'roomsStatus': newActivity.roomsStatus,
        'startTime': newActivity.startTime,
        'endTime': newActivity.endTime,
        'overallStatus': newActivity.overallStatus,
        'bookingId': newActivity.bookingId
      });
    } catch (error) {
      print(error);
      Get.snackbar("Error", "$error");
    }
  }

// Update room status
  Future<void> updateActivity({
    bool? newValue,
    int? roomIndex,
    required String activityId,
    String? statusOverall,
  }) async {
    try {
      // Ensure the activity ID is provided
      if (activityId.isEmpty) {
        throw Exception("Activity ID is required.");
      }

      // Initialize an update map
      Map<String, dynamic> updates = {};

      // Fetch the document if roomsStatus needs modification
      if (roomIndex != null && newValue != null) {
        // Get the current document
        DocumentSnapshot doc = await activitiesCollection.doc(activityId).get();

        // Retrieve the existing roomsStatus array
        List<Map<String, dynamic>> roomsStatus =
            List<Map<String, dynamic>>.from(doc['roomsStatus']);

        // Update the specific room's status
        roomsStatus[roomIndex]['status'] = newValue;

        // Add roomsStatus to the update map
        updates['roomsStatus'] = roomsStatus;
      }

      // Add overallStatus to the update map if provided
      if (statusOverall != null) {
        updates['overallStatus'] = statusOverall;
        updates['endTime'] = DateTime.now();
      }

      // Perform the update if there are changes
      if (updates.isNotEmpty) {
        await activitiesCollection.doc(activityId).update(updates);
      } else {
        print("No changes to update.");
        return;
      }

      // Fetch the updated document from Firestore
      DocumentSnapshot updatedDoc =
          await activitiesCollection.doc(activityId).get();

      // Update the loadedActivity in the controller
      loadedActivity.value = ActivityDomain(
        List<Map<String, dynamic>>.from(updatedDoc['roomsStatus']),
        updatedDoc['startTime'],
        updatedDoc['endTime'],
        updatedDoc['overallStatus'],
        activityId,
        updatedDoc['bookingId'],
      );

      print("Activity successfully updated and reloaded.");
    } catch (error) {
      print("Error updating activity: $error");
      Get.snackbar("Error", "Failed to update activity.");
    }
  }
}
