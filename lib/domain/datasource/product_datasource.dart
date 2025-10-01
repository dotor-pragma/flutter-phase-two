import 'package:dartz/dartz.dart';

import 'package:fase_2/core/errors/failure.dart';
import 'package:fase_2/domain/entities/product_entity.dart';

abstract class ProductDatasource {
  Future<Either<Failure, List<ProductEntity>>> getAll();
}
