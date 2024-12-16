import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CleanerDashboardPage extends StatefulWidget {
  const CleanerDashboardPage({super.key});

  @override
  State<CleanerDashboardPage> createState() => _CleanerDashboardPageState();
}

class _CleanerDashboardPageState extends State<CleanerDashboardPage> {
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
        title: const Text("Cleaner Dashboard"),
      ),
      body: const Center(
        child: Text("Cleaner dashboard page"),
      ),
    );
  }
}
