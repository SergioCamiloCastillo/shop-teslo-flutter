import 'package:flutter/material.dart';
import 'package:teslo_shop_flutter/features/shared/shared.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text('Productos'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: _ProductsView(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text("Nuevo producto"),
        icon: Icon(Icons.add),
      ),
    );
  }
}

class _ProductsView extends StatelessWidget {
  const _ProductsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text('algo');
  }
}
