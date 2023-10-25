import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductCreateUpdateScreen extends ConsumerStatefulWidget {
  final String productId;
  const ProductCreateUpdateScreen({super.key, required this.productId});

  @override
  ConsumerState<ProductCreateUpdateScreen> createState() =>
      _ProductCreateUpdateScreenState();
}

class _ProductCreateUpdateScreenState
    extends ConsumerState<ProductCreateUpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Editar producto'),
        ),
        body: Center(
          child: Text(widget.productId),
        ));
  }
}
