import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../providers/user_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserProvider userProvider = Get.find<UserProvider>();
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GetX<UserProvider>(builder: (userProvider) {
          return Text(userProvider.userLogin.role);
        }),
        ElevatedButton(
            onPressed: () {
              userProvider.signOut();
            },
            child: Text("Sign Out")),
      ],
    ));
  }
}
