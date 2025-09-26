import 'package:flutter/material.dart';

import 'package:fase_2/features/store/domain/entities/product_entity.dart';
import 'package:fase_2/features/store/domain/repositories/product_repository.dart';

class StoreProvider extends ChangeNotifier {
  final ProductRepository productRepository;

  StoreProvider({required this.productRepository});

  bool isLoading = true;
  final List<ProductEntity> products = [];

  Future<void> getAllProducts() async {
    final result = await productRepository.getAll();
    if (result.isNotEmpty) {
      products.addAll(result);
    }
    isLoading = false;
    notifyListeners();
  }
}
