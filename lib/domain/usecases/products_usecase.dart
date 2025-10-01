import 'package:dartz/dartz.dart';

import 'package:fase_2/core/errors/failure.dart';
import 'package:fase_2/domain/entities/product_entity.dart';
import 'package:fase_2/domain/repositories/product_repository.dart';

class GetAllProductsUseCase {
  final ProductRepository _productRepository;

  GetAllProductsUseCase({required ProductRepository productRepository})
    : _productRepository = productRepository;

  Future<Either<Failure, List<ProductEntity>>> call() {
    return _productRepository.getAll();
  }
}
