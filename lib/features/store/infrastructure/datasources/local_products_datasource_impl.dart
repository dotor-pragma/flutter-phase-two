import 'package:fase_2/features/store/domain/datasource/product_datasource.dart';
import 'package:fase_2/features/store/domain/entities/product_entity.dart';
import 'package:fase_2/features/store/infrastructure/models/product_model.dart';
import 'package:fase_2/shared/data/local_fake_data.dart';

class LocalProductsDatasourceImpl implements ProductDatasource {
  const LocalProductsDatasourceImpl();

  @override
  Future<List<ProductEntity>> getAll() async {
    final List<ProductEntity> products = localFakeData
        .map((product) => ProductModel.fromJson(product).toProductEntity())
        .toList();
    return products;
  }
}
