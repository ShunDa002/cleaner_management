import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../providers/user_provider.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final UserProvider userProvider = Get.find<UserProvider>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController roleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                controller: emailController,
              ),
              SizedBox(height: 30),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                controller: passwordController,
                obscureText: true,
              ),
              SizedBox(height: 30),
              TextFormField(
                decoration: InputDecoration(labelText: 'Role'),
                controller: roleController,
              ),
              ElevatedButton(
                  onPressed: () {
                    final email = emailController.text.trim();
                    final password = passwordController.text;
                    final role = roleController.text.trim();

                    if (!GetUtils.isEmail(email)) {
                      Get.snackbar(
                        "Invalid Email",
                        "Please enter a valid email address.",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      return;
                    }

                    if (password.length < 6) {
                      Get.snackbar(
                        "Invalid Password",
                        "Password must be at least 6 characters long.",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      return;
                    }

                    userProvider.createUser(email, password, role);
                  },
                  child: Text("Sign Up")),
            ],
          ),
        ),
      ),
    );
  }
}
