import 'package:flutter/material.dart';
import './pages/tabs.dart';
import './routers/routers.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/", // default route
      defaultTransition: Transition.rightToLeft,
      getPages: AppPage.routes,
      home: const Tabs(),
    );
  }
}
