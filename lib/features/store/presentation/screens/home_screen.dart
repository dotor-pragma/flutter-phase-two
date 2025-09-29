import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fase_2/features/store/presentation/providers/store_provider.dart';
import 'package:fase_2/features/store/presentation/widgets/card_product.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final storeProvider = context.watch<StoreProvider>();
    Widget body;
    if (storeProvider.isLoading) {
      body = const Center(child: CircularProgressIndicator(strokeWidth: 2));
    } else if (storeProvider.failure != null) {
      body = Center(
        child: Text(
          storeProvider.failure!.message,
          style: const TextStyle(color: Colors.redAccent),
        ),
      );
    } else {
      body = ListView.builder(
        itemCount: storeProvider.products.length,
        itemBuilder: (context, index) {
          final product = storeProvider.products[index];
          return CardProduct(product: product);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: body,
    );
  }
}
