import 'package:fase_2/features/store/domain/entities/product_entity.dart';

abstract class ProductDatasource {
  Future<List<ProductEntity>> getAll();
}
