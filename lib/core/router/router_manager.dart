import 'package:go_router/go_router.dart';
import 'package:the_coffee_hand_mobile/core/router/routes.dart';
import 'package:the_coffee_hand_mobile/features/auth/login/view/login_view.dart';
import 'package:the_coffee_hand_mobile/navigation/view/navigation_view.dart';
import 'package:the_coffee_hand_mobile/features/splashs/view/splash_view.dart';

final class RouterManager {
  RouterManager._();
  static GoRouter get router => _routes;

  static final _routes = GoRouter(
    routes: [
      GoRoute(
        path: Routes.initial.path,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: Routes.navigation.path,
        builder: (context, state) => const NavigationView(),
      ),
      GoRoute(
        path: Routes.login.path,
        builder: (context, state) => const LoginView(),
      ),
    ],
  );
}
