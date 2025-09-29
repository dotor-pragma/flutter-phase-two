import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fase_2/features/store/presentation/providers/store_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final storeProvider = context.watch<StoreProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: storeProvider.isLoading
          ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
          : ListView.builder(
              itemCount: storeProvider.products.length,
              itemBuilder: (context, index) {
                final product = storeProvider.products[index];
                return ListTile(
                  title: Text(product.title),
                  subtitle: Text(product.price.toString()),
                );
              },
            ),
    );
  }
}
