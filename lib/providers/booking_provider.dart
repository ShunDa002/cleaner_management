/* 
Booking Provider 
Here you define what the app can do.
*/

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../domains/booking_domain.dart';

class BookingProvider extends GetxController {
  var isLoading = true.obs; // Make it reactive
  var bookingList = <Map<String, dynamic>>[].obs; // Use a reactive list

  // Fetch bookings from Firestore
  final CollectionReference bookingsCollection =
      FirebaseFirestore.instance.collection('bookings');
  // Fetch activities from Firestore
  final CollectionReference activitiesCollection =
      FirebaseFirestore.instance.collection('activities');

  // Get all bookings where the associated activity's overallStatus is not in ["completed"]
  Future<void> getAllNotCompletedBookings() async {
    try {
      isLoading.value = true;

      // Step 1: Query activities where overallStatus is "completed"
      QuerySnapshot completedActivitiesSnapshot = await activitiesCollection
          .where('overallStatus', isEqualTo: 'completed')
          .get();

      // Extract booking IDs of completed activities
      List<String> completedBookingIds = completedActivitiesSnapshot.docs
          .map((doc) => doc['bookingId'] as String)
          .toList();

      // // Step 2: Query bookings that match the bookingIds
      // QuerySnapshot bookingsSnapshot = await bookingsCollection
      //     .where(FieldPath.documentId, whereIn: bookingIds)
      //     .orderBy('address')
      //     .get();

      // Step 2: Query bookings excluding those with completed activities
      QuerySnapshot bookingsSnapshot;

      if (completedBookingIds.isEmpty) {
        // No completed activities, fetch all bookings
        bookingsSnapshot = await bookingsCollection
            .orderBy('timestamp', descending: false)
            .get();
      } else {
        // Fetch bookings not in completedBookingIds
        bookingsSnapshot = await bookingsCollection
            .where(FieldPath.documentId, whereNotIn: completedBookingIds)
            .orderBy('timestamp', descending: false)
            .get();
      }

      // Step 3: Map the bookings data into a list
      bookingList.value = bookingsSnapshot.docs.map((booking) {
        return {
          "id": booking.id,
          "address": booking['address'],
          "payment": booking['payment'],
        };
      }).toList();
    } catch (error) {
      print('Error fetching bookings: $error');
      Get.snackbar("Error", "$error");
    } finally {
      isLoading.value = false; // Ensure loading state is updated
    }
  }

  // CREATE: Add new booking
  Future<void> addBooking(String address) {
    return bookingsCollection.add({
      'address': address,
      'timestamp': Timestamp.now(),
      'payment': 200.00,
    });
  }

  // // READ: Get bookings from db
  // Stream<QuerySnapshot> getBookingsStream() {
  //   final bookingsStream =
  //       bookings.orderBy('timestamp', descending: true).snapshots();
  //   return bookingsStream;
  // }

  // // Update existing booking
  // Future<void> updateBooking(String docID, Booking booking) {
  //   return bookings.doc(docID).update({
  //     'address': booking.address,
  //     'timestamp': Timestamp.now(),
  //   });
  // }

  // // Delete booking
  // Future<void> deleteBooking(String docID) {
  //   return bookings.doc(docID).delete();
  // }
}
