import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop_flutter/features/products/presentation/providers/providers.dart';

class ProductCreateUpdateScreen extends ConsumerWidget {
  final String productId;
  const ProductCreateUpdateScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productProvider(productId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar producto'),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.camera_alt_outlined))
        ],
      ),
      body: Center(
        child: Text(productState.product?.title ?? 'Cargando...'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.save_alt_outlined),
      ),
    );
  }
}
