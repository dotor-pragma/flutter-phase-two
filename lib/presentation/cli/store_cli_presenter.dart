import 'dart:io';

import 'package:fase_2/core/errors/failure.dart';
import 'package:fase_2/domain/entities/product_entity.dart';
import 'package:fase_2/domain/usecases/products_usecase.dart';

class StoreCliPresenter {
  StoreCliPresenter({required GetAllProductsUseCase getAllProductsUseCase})
      : _getAllProductsUseCase = getAllProductsUseCase;

  final GetAllProductsUseCase _getAllProductsUseCase;

  Future<void> fetchAndPrintProducts() async {
    stdout.writeln('\n=== Fake Store Products ===');
    final result = await _getAllProductsUseCase();

    result.fold(_printFailure, _printProducts);
  }

  void _printFailure(Failure failure) {
    stdout
      ..writeln('No se pudieron obtener los productos.')
      ..writeln(failure.toString());
  }

  void _printProducts(List<ProductEntity> products) {
    if (products.isEmpty) {
      stdout.writeln('No se encontraron productos para mostrar.');
      return;
    }

    for (final product in products) {
      stdout
        ..writeln('------------------------------')
        ..writeln('ID: ${product.id}')
        ..writeln('Title: ${product.title}')
        ..writeln('Category: ${product.category}')
        ..writeln('Price: ${product.price}')
        ..writeln('Rating: ${product.rating.rate} (${product.rating.count} reviews)')
        ..writeln('Description: ${product.description}')
        ..writeln('Image: ${product.image}');
    }

    stdout
      ..writeln('------------------------------')
      ..writeln('Total productos: ${products.length}\n');
  }
}
