import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:the_coffee_hand_mobile/core/router/routes.dart';

class ProfileNoLoginView extends StatelessWidget {
  const ProfileNoLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "You are not logged in",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Điều hướng đến trang đăng nhập
                context.go(Routes.login.path);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown, // Màu nâu
                foregroundColor: Colors.white, // Chữ trắng
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: const Text("Go to Login Page"),
            ),
          ],
        ),
      ),
    );
  }
}