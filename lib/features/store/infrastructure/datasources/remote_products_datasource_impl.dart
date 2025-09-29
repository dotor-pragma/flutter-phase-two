import 'package:fase_2/core/network/dio_client.dart';
import 'package:fase_2/features/store/domain/datasource/product_datasource.dart';
import 'package:fase_2/features/store/domain/entities/product_entity.dart';
import 'package:fase_2/features/store/infrastructure/models/product_model.dart';

class RemoteProductsDatasourceImpl implements ProductDatasource {
  RemoteProductsDatasourceImpl();

  @override
  Future<List<ProductEntity>> getAll() async {
    try {
      final response = await DioClient.dio.get('/products');
      final List<dynamic> data = response.data;
      final List<ProductEntity> products = data
          .map((product) => ProductModel.fromJson(product).toProductEntity())
          .toList();
      return products;
    } catch (e) {
      throw Exception('Error al obtener los productos');
    }
  }
}
