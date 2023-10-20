import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';
import 'package:teslo_shop_flutter/config/router/app_router_notifier.dart';
import 'package:teslo_shop_flutter/features/auth/presentation/screens/screens.dart';
import 'package:teslo_shop_flutter/features/products/presentation/screens/screens.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);
  return GoRouter(
    initialLocation: "/splash",
    //refreshListenable, cuando cambie va a volver a evaluar el redirect
    refreshListenable: goRouterNotifier,
    routes: [
      GoRoute(
        path: "/splash",
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),
      GoRoute(
        path: "/register",
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: "/login",
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: "/",
        builder: (context, state) => const ProductsScreen(),
      )
    ],
    redirect: (context, state) {
      return null;
    },
  );
});
