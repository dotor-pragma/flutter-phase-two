import 'package:fase_2/features/store/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> getAll();
}
