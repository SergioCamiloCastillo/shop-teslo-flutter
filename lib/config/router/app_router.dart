import 'package:go_router/go_router.dart';
import 'package:teslo_shop_flutter/features/auth/presentation/screens/screens.dart';
import 'package:teslo_shop_flutter/features/products/presentation/screens/screens.dart';

final appRouter = GoRouter(initialLocation: "/login", routes: [
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
]);
