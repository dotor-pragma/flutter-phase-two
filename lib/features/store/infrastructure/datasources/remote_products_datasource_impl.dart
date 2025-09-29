import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:fase_2/core/errors/failure.dart';
import 'package:fase_2/features/store/domain/datasource/product_datasource.dart';
import 'package:fase_2/features/store/domain/entities/product_entity.dart';
import 'package:fase_2/features/store/infrastructure/models/product_model.dart';

class RemoteProductsDatasourceImpl implements ProductDatasource {
  RemoteProductsDatasourceImpl(this.dio);

  final Dio dio;

  @override
  Future<Either<Failure, List<ProductEntity>>> getAll() async {
    try {
      final response = await dio.get('/products');
      final payload = response.data;

      //simular error
      //throw Exception('Error al obtener los productos');
      //throw DioException(requestOptions: RequestOptions());

      final products = payload
          .whereType<Map<String, dynamic>>()
          .map((product) => ProductModel.fromJson(product).toProductEntity())
          .toList();
      return right(products);
    } on DioException catch (dioError) {
      final statusCode = dioError.response?.statusCode;
      final message = dioError.response?.statusMessage ?? dioError.message;
      return left(
        Failure(
          message ?? 'Error al obtener los productos',
          statusCode: statusCode,
          code: dioError.type.name,
        ),
      );
    } catch (_) {
      return left(
        const Failure(
          'Error desconocido al obtener los productos',
          code: 'unknown',
        ),
      );
    }
  }
}
