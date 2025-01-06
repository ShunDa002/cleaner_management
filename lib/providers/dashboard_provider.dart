import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardProvider extends GetxController {
  // Observable variables for reactive updates
  var totalBookings = 0.obs;
  var totalEarnings = 0.0.obs;
  var lastSevenDaysPayments = <FlSpot>[].obs;
  var currentDate = DateTime.now().obs;

  // Firestore bookings collection reference
  final CollectionReference bookingsCollection =
      FirebaseFirestore.instance.collection('bookings');

  // Fetch bookings summary from Firestore
  Future<void> getBookingSummary() async {
    try {
      // Calculate the timestamp for 7 days ago
      final now = Timestamp.now();
      final sevenDaysAgo = Timestamp.fromMillisecondsSinceEpoch(
        now.millisecondsSinceEpoch -
            7 * 24 * 60 * 60 * 1000, // Subtract 7 days in milliseconds
      );

      // Query Firestore for bookings within the last 7 days
      final snapshot = await bookingsCollection
          .where('timestamp', isGreaterThanOrEqualTo: sevenDaysAgo)
          .get();

      // Temporary counters to hold calculations
      int bookingCount = 0;
      double earningsSum = 0.0;

      // Iterate over each document in the query result
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;

        // Increment booking count
        bookingCount += 1;

        // Add the payment amount (ensure null safety)
        earningsSum += (data['payment'] ?? 0.0) as double;
      }

      // Update reactive variables
      totalBookings.value = bookingCount;
      totalEarnings.value = earningsSum;

      print("Total Bookings: ${totalBookings.value}");
      print("Total Earnings: ${totalEarnings.value.toStringAsFixed(2)}");
    } catch (error) {
      print("Error getting booking summary: $error");
    }
  }

  Future<void> getLastSevenDaysPayment() async {
    try {
      // Current timestamp and month
      final now = DateTime.now();
      final currentMonth = now.month;
      final List<FlSpot> spots = [];

      // Initialize reactive state for current date
      currentDate.value = now;

      // Calculate the timestamp for 7 days ago
      final sevenDaysAgo = now.subtract(Duration(days: 7));

      // Initialize a map for payments with 0 for each day in the last 7 days
      Map<int, double> dailyPayments = {};
      for (int i = 0; i < 7; i++) {
        final date = now.subtract(Duration(days: i));
        if (date.month == currentMonth) {
          dailyPayments[date.day] = 0.0; // Initialize with 0 payments
        }
      }

      // Query Firestore for bookings in the last 7 days
      final snapshot = await bookingsCollection
          .where('timestamp',
              isGreaterThanOrEqualTo: Timestamp.fromDate(sevenDaysAgo))
          .where('timestamp', isLessThanOrEqualTo: Timestamp.fromDate(now))
          .get();

      // Process each document
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final timestamp = data['timestamp'] as Timestamp;
        final payment = (data['payment'] ?? 0.0) as double;

        // Convert timestamp to DateTime and extract day and month
        final date = timestamp.toDate();
        final dayOfMonth = date.day;
        final month = date.month;

        // Only include payments from the current month
        if (month == currentMonth && dailyPayments.containsKey(dayOfMonth)) {
          dailyPayments[dayOfMonth] = (dailyPayments[dayOfMonth]! + payment);
        }
      }

      // Generate FlSpot objects including days with 0 payments
      spots.addAll(dailyPayments.entries
          .map((entry) => FlSpot(entry.key.toDouble(), entry.value)));

      // Update reactive state
      lastSevenDaysPayments.value = spots;

      print(
          "Last 7 Days Payments (Filtered for Current Month with 0s): $lastSevenDaysPayments");
    } catch (error) {
      print("Error retrieving last 7 days payments: $error");
    }
  }
}
