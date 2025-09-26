import 'package:fase_2/features/store/domain/datasource/product_datasource.dart';
import 'package:fase_2/features/store/domain/entities/product_entity.dart';
import 'package:fase_2/features/store/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDatasource datasource;

  ProductRepositoryImpl({required this.datasource});

  @override
  Future<List<ProductEntity>> getAll() async {
    return await datasource.getAll();
  }
}
