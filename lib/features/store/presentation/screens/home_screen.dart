import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fase_2/features/store/presentation/providers/store_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final storeProvider = context.watch<StoreProvider>();
    return Scaffold(
      body: storeProvider.isLoading
          ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
          : Center(child: Text('Home ${storeProvider.products.length}')),
    );
  }
}
