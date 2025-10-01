import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fase_2/features/store/presentation/providers/store_viewmodel.dart';
import 'package:fase_2/features/store/presentation/widgets/card_product.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final storeViewModel = context.watch<StoreViewModel>();
    Widget body;
    if (storeViewModel.isLoading) {
      body = const Center(child: CircularProgressIndicator(strokeWidth: 2));
    } else if (storeViewModel.failure != null) {
      body = Center(
        child: Text(
          storeViewModel.failure!.message,
          style: const TextStyle(color: Colors.redAccent),
        ),
      );
    } else {
      body = ListView.builder(
        itemCount: storeViewModel.products.length,
        itemBuilder: (context, index) {
          final product = storeViewModel.products[index];
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
