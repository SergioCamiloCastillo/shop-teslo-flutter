import 'package:go_router/go_router.dart';
import 'package:teslo_shop_flutter/features/products/presentation/screens/products_screen.dart';

final appRouter = GoRouter(initialLocation: "/", routes: [
  GoRoute(
    path: "/",
    builder: (context, state) => ProductsScreen(),
  )
]);
