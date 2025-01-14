import 'package:firebase_core/firebase_core.dart';
import 'package:cleaner_management/firebase_options.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import './pages/tabs.dart';
import './routers/routers.dart';
import './binding/controller_binding.dart';
import '../../providers/user_provider.dart';
import './pages/users/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      home: Obx(() {
        return Get.find<UserProvider>().user != null ? Tabs() : Login();
      }),
      initialBinding: ControllerBinding(),
    );
  }
}
