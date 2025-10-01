import 'dart:io';

import 'package:fase_2/core/errors/failure.dart';
import 'package:fase_2/domain/entities/product_entity.dart';
import 'package:fase_2/domain/usecases/products_usecase.dart';

class StoreCliPresenter {
  final GetAllProductsUseCase _getAllProductsUseCase;

  StoreCliPresenter({required GetAllProductsUseCase getAllProductsUseCase})
    : _getAllProductsUseCase = getAllProductsUseCase;

  // ANSI escape codes to controlar estilo y color en la terminal.
  static const String _reset = '\x1B[0m'; // Quita cualquier estilo aplicado.
  static const String _bold = '\x1B[1m'; // Activa texto en negrita.
  static const String _headerColor =
      '\x1B[95m'; // Magenta suave para encabezados.
  static const String _dividerColor = '\x1B[90m'; // Gris para separadores.
  static const String _titleColor =
      '\x1B[96m'; // Cian para título del producto.
  static const String _categoryColor =
      '\x1B[93m'; // Amarillo para la categoría.
  static const String _priceColor = '\x1B[92m'; // Verde para el precio.
  static const String _mutedColor =
      '\x1B[90m'; // Gris tenue para detalles secundarios.
  static const String _errorColor = '\x1B[31m'; // Rojo para mensajes de error.
  static const String _warningColor = '\x1B[33m'; // Amarillo para advertencias.
  static const String _divider =
      '============================================'; // Línea base para separar bloques.

  Future<void> fetchAndPrintProducts() async {
    _printHeader();
    final result = await _getAllProductsUseCase();

    result.fold(_printFailure, _printProducts);
  }

  void _printHeader() {
    stdout
      ..writeln('')
      ..writeln(
        _styled('🛒  Fake Store Products', color: _headerColor, bold: true),
      )
      ..writeln(_styled(_divider, color: _dividerColor));
  }

  void _printFailure(Failure failure) {
    stderr
      ..writeln(
        _styled('No se pudieron obtener los productos.', color: _errorColor),
      )
      ..writeln('$failure');
  }

  void _printProducts(List<ProductEntity> products) {
    if (products.isEmpty) {
      _printNoProducts();
      return;
    }

    for (final product in products) {
      _printProduct(product);
    }

    _printFooter(products.length);
  }

  void _printNoProducts() {
    stderr.writeln(
      _styled(
        'No se encontraron productos para mostrar.',
        color: _warningColor,
      ),
    );
  }

  void _printProduct(ProductEntity product) {
    final price = product.price.toStringAsFixed(2);
    final rating = product.rating.rate.toStringAsFixed(1);

    stdout
      ..writeln(_styled(_divider, color: _dividerColor))
      ..writeln(
        _styled(
          'ID: ${product.id} — ${product.title}',
          color: _titleColor,
          bold: true,
        ),
      )
      ..writeln(
        _styled('Categoría: ${product.category}', color: _categoryColor),
      )
      ..writeln(_styled('Precio (USD): $price', color: _priceColor))
      ..writeln(
        _styled(
          'Calificación: $rating (${product.rating.count} reseñas)',
          color: _titleColor,
        ),
      )
      ..writeln(
        _styled('Descripción: ${product.description}', color: _mutedColor),
      )
      ..writeln(_styled('Imagen: ${product.image}', color: _mutedColor));
  }

  void _printFooter(int totalProducts) {
    stdout
      ..writeln(_styled(_divider, color: _dividerColor))
      ..writeln(_styled('Total productos: $totalProducts', color: _headerColor))
      ..writeln('');
  }

  String _styled(String text, {String? color, bool bold = false}) {
    final colorCode = color ?? '';
    final boldCode = bold ? _bold : '';

    if (colorCode.isEmpty && boldCode.isEmpty) {
      return text;
    }

    return '$colorCode$boldCode$text$_reset';
  }
}
