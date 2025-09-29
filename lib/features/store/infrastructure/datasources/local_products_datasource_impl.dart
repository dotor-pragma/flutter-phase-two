import 'package:dartz/dartz.dart';

import 'package:fase_2/core/errors/failure.dart';
import 'package:fase_2/features/store/domain/datasource/product_datasource.dart';
import 'package:fase_2/features/store/domain/entities/product_entity.dart';
import 'package:fase_2/features/store/infrastructure/models/product_model.dart';
import 'package:fase_2/shared/data/local_fake_data.dart';

class LocalProductsDatasourceImpl implements ProductDatasource {
  const LocalProductsDatasourceImpl();

  @override
  Future<Either<Failure, List<ProductEntity>>> getAll() async {
    final products = localFakeData
        .map((product) => ProductModel.fromJson(product).toProductEntity())
        .toList();
    return right(products);
  }
}
