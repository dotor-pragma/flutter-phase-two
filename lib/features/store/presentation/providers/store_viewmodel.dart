import 'dart:collection';
import 'package:flutter/material.dart';

import 'package:fase_2/core/errors/failure.dart';
import 'package:fase_2/features/store/domain/entities/product_entity.dart';
import 'package:fase_2/features/store/domain/usecases/products_usecase.dart';

class StoreViewModel extends ChangeNotifier {
  final GetAllProductsUseCase _getAllProductsUseCase;

  StoreViewModel({required GetAllProductsUseCase getAllProductsUseCase})
    : _getAllProductsUseCase = getAllProductsUseCase;

  bool isLoading = true;
  Failure? failure;

  final List<ProductEntity> _products = [];

  List<ProductEntity> get products => UnmodifiableListView(_products);

  Future<void> getAllProducts() async {
    final result = await _getAllProductsUseCase();
    result.fold(
      (error) {
        failure = error;
        _products.clear();
      },
      (data) {
        failure = null;
        _products
          ..clear()
          ..addAll(data);
        _logProducts(_products);
      },
    );
    isLoading = false;
    notifyListeners();
  }

  void _logProducts(List<ProductEntity> items) {
    if (items.isEmpty) {
      debugPrint('No se encontraron productos para mostrar.');
      return;
    }

    debugPrint('===== Productos obtenidos (${items.length}) =====');
    for (final p in items) {
      debugPrint('--------------------------------------------');
      debugPrint(p.toString());
    }
  }
}
