import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateStatusPage extends StatefulWidget {
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
      body: const Center(
        child: Text("Activity status page"),
      ),
    );
  }
}
