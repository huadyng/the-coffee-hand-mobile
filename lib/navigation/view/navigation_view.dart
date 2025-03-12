import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_coffee_hand_mobile/features/auth/login/view/login_view.dart';
import 'package:the_coffee_hand_mobile/features/home/view/home_view.dart';
import 'package:the_coffee_hand_mobile/features/category/view/category_view.dart';
import 'package:the_coffee_hand_mobile/features/cart/view/cart_view.dart';
import 'package:the_coffee_hand_mobile/features/profile/view/profile_view.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  late CupertinoTabController tabController;
  User? _user; // Biến lưu trạng thái user

  @override
  void initState() {
    super.initState();
    tabController = CupertinoTabController();

    // Lắng nghe trạng thái đăng nhập của Firebase
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        _user = user; // Cập nhật trạng thái user
      });
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  bool get isLoggedIn => _user != null; // Nếu user tồn tại, tức là đã đăng nhập

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      controller: tabController,
      tabBar: CupertinoTabBar(
        currentIndex: tabController.index,
        onTap: (index) {
          if (index == 3 && !isLoggedIn) {
            // Nếu chưa đăng nhập, mở màn hình đăng nhập
            Navigator.of(context, rootNavigator: true).push(
              CupertinoPageRoute(
                builder: (context) => const LoginView(),
              ),
            );
          } else {
            // Chuyển đổi tab bình thường
            setState(() {
              tabController.index = index;
            });
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.house_alt_fill), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.square_grid_2x2), label: 'Category'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.bag_fill), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_solid), label: 'Profile'),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) => const HomeView());
          case 1:
            return CupertinoTabView(builder: (context) => const CategoryView());
          case 2:
            return CupertinoTabView(builder: (context) => const CartView());
          case 3:
            return CupertinoTabView(
              builder: (context) => isLoggedIn ? const ProfileView() : const LoginView(),
            );
          default:
            return CupertinoTabView(builder: (context) => const HomeView());
        }
      },
    );
  }
}
