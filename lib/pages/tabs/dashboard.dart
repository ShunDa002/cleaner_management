import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../dashboard/cleaner_dashboard.dart';

import '../../providers/dashboard_provider.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  final DashboardProvider dashboardProvider = Get.find<DashboardProvider>();

  @override
  Widget build(BuildContext context) {
    // Fetch data when the widget is built
    dashboardProvider.getBookingSummary();

    return Center(
      child: CleanerDashboardPage(),
      /* child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(onPressed: () {}, child: Text("Last 7 days")),
            ],
          ),
          Container(
              height: 100,
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(5.0)),
              child: Column(
                children: [
                  Text("Total Cleaned House",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  Divider(),
                  Obx(() => Text(
                        '${dashboardProvider.totalBookings.value} units',
                        style: TextStyle(fontSize: 20),
                      )),
                ],
              )),
          Container(
              height: 100,
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(5.0)),
              child: Column(
                children: [
                  Text("Total Earning",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  Divider(),
                  Obx(() => Text(
                        'RM ${dashboardProvider.totalEarnings.value.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 20),
                      )),
                ],
              )),
          SizedBox(
            height: 40,
            width: 300,
            child: ElevatedButton.icon(
              icon: Icon(Icons.chevron_right_outlined),
              onPressed: () {
                Get.toNamed("/cleanerdashboard",
                    arguments: {"title": "I am cleaner dashboard", "id": 1});
              },
              label: Text("View more ..."),
              iconAlignment: IconAlignment.end,
            ),
          ),
          SizedBox(
            height: 50,
          )
        ],
      ), */
    );
  }
}

/* class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

// ONLY Display last 7 days bcoz easier to implement
class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      // child: CleanerDashboardPage(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(onPressed: () {}, child: Text("Past 7 days")),
            ],
          ),
          Container(
              height: 100,
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(5.0)),
              child: Column(
                children: [
                  Text("Total Cleaned House",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  Divider(),
                  Text("xxx units", style: TextStyle(fontSize: 18)),
                ],
              )),
          Container(
              height: 100,
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(5.0)),
              child: Column(
                children: [
                  Text("Total Earning",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  Divider(),
                  Text("RM xxxx.xx", style: TextStyle(fontSize: 18)),
                ],
              )),
          SizedBox(
            height: 40,
            width: 300,
            child: ElevatedButton.icon(
              icon: Icon(Icons.chevron_right_outlined),
              onPressed: () {
                Get.toNamed("/cleanerdashboard",
                    arguments: {"title": "I am cleaner dashboard", "id": 1});
              },
              label: Text("View more ..."),
              iconAlignment: IconAlignment.end,
            ),
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );

    /* Center(
      child: Column(
        children: [
          const Text('Dashboard Page'),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                Get.toNamed("/cleanerdashboard",
                    arguments: {"title": "I am cleaner dashboard", "id": 1});
              },
              child: const Text("Cleaner dashboard"))
        ],
      ),
    ); */
  }
} */
