import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:the_coffee_hand_mobile/core/router/routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      context.go(Routes.navigation.path); // Chuyển sang màn hình chính
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.coffee, size: 80, color: Colors.brown),
            SizedBox(height: 20),
            Text("Welcome to The Coffee Hand",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
