import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/router/router_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeFirebase();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'The Coffee Hand',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      routerConfig: RouterManager.router, // Sử dụng go_router để điều hướng
    );
  }
}

Future<void> _initializeFirebase() async {
  try {
    // 🔹 Kiểm tra xem Firebase đã được khởi tạo chưa, nếu rồi thì không khởi tạo lại
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: "AIzaSyBMw9ha3W4Cd5uTYoJ0BEE2ieKZeo5Liak",
          authDomain: "thecoffeehand-3bf49.firebaseapp.com",
          projectId: "thecoffeehand-3bf49",
          storageBucket: "thecoffeehand-3bf49.appspot.com",
          messagingSenderId: "137349428578",
          appId: "1:137349428578:web:b327b29b43d2c5df5b283b",
          measurementId: "G-MDN5GXTQ3H",
        ),
      );
      print("Firebase đã được khởi tạo thành công!");
    } else {
      print("Firebase đã tồn tại, không cần khởi tạo lại.");
    }
  } catch (e) {
    print("Lỗi khởi tạo Firebase: $e");
  }
}
