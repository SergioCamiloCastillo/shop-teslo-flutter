import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';
import 'package:teslo_shop_flutter/config/router/app_router_notifier.dart';
import 'package:teslo_shop_flutter/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop_flutter/features/auth/presentation/providers/provider.dart';
import 'package:teslo_shop_flutter/features/auth/presentation/screens/screens.dart';
import 'package:teslo_shop_flutter/features/products/presentation/screens/screens.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);
  final loginFormNotifier = ref.read(loginFormProvider);
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
      final isGoingTo = state.matchedLocation;
      final authStatus = goRouterNotifier.authStatus;
      
      if (isGoingTo == '/splash' && authStatus == AuthStatus.checking) {
        print('es $isGoingTo y status es $authStatus');
        return null;
      }
      if (authStatus == AuthStatus.notAuthenticated) {
        if (isGoingTo == '/login' || isGoingTo == '/register') return null;
        return '/login';
      }
      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/register' ||
            isGoingTo == '/splash') return '/';
      }
      return null;
    },
  );
});
