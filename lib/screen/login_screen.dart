import 'package:demo_interview/controllers/auth_controller.dart';
import 'package:demo_interview/utils/app_routes.dart';
import 'package:demo_interview/utils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController authController = Get.put(AuthController());

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CommonTextField(
              controller: emailController,
              hintText: 'Email',
            ),
            SizedBox(height: 16),
            CommonTextField(
              controller: passwordController,
              hintText: 'Password',
              isPassword: true,
            ),
            SizedBox(height: 16),
            CommonButton(
              label: 'Login',
              onPressed: () {
                authController.login();
              },
            ),
            TextButton(
              onPressed: () {
                Get.toNamed(AppRoutes.signup);
              },
              child: Text('Don\'t have an account? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
