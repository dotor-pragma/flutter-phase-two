import 'package:flutter/material.dart';

import 'package:fase_2/core/errors/failure.dart';
import 'package:fase_2/features/store/domain/entities/product_entity.dart';
import 'package:fase_2/features/store/domain/usecases/products_usecase.dart';

class StoreProvider extends ChangeNotifier {
  final GetAllProductsUseCase _getAllProductsUseCase;

  StoreProvider({required GetAllProductsUseCase getAllProductsUseCase})
    : _getAllProductsUseCase = getAllProductsUseCase;

  bool isLoading = true;
  Failure? failure;

  final List<ProductEntity> products = [];

  Future<void> getAllProducts() async {
    final result = await _getAllProductsUseCase();
    result.fold(
      (error) {
        failure = error;
        products.clear();
      },
      (data) {
        failure = null;
        products
          ..clear()
          ..addAll(data);
      },
    );
    isLoading = false;
    notifyListeners();
  }
}
