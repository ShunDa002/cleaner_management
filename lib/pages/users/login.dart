import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './signup.dart';
import '../../providers/user_provider.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final UserProvider userProvider = Get.find<UserProvider>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
              ElevatedButton(
                  onPressed: () {
                    userProvider.login(
                        emailController.text, passwordController.text);
                  },
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  child: Text("Login")),
              TextButton(
                  onPressed: () {
                    Get.to(SignUp());
                  },
                  child: Text("Sign Up")),
            ],
          ),
        ),
      ),
    );
  }
}
