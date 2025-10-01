import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:fase_2/core/errors/failure.dart';
import 'package:fase_2/domain/datasource/product_datasource.dart';
import 'package:fase_2/domain/entities/product_entity.dart';
import 'package:fase_2/infrastructure/models/product_model.dart';

class RemoteProductsDatasourceImpl implements ProductDatasource {
  RemoteProductsDatasourceImpl(this.dio);

  final Dio dio;

  @override
  Future<Either<Failure, List<ProductEntity>>> getAll() async {
    try {
      final response = await dio.get('/products');
      final payload = response.data as List<dynamic>;

      //simular error
      //throw Exception('Error al obtener los productos');
      //throw DioException(requestOptions: RequestOptions());

      /* if (payload is! Iterable) {
        return left(
          const Failure(
            'Formato inesperado de respuesta',
            code: 'invalid_response',
          ),
        );
      } */

      final products = payload
          .map(
            (product) => ProductModel.fromJson(
              product as Map<String, dynamic>,
            ).toProductEntity(),
          )
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
    } catch (error) {
      return left(
        Failure(
          'Error al procesar los productos: ${error.toString()}',
          code: 'parse_error',
        ),
      );
    }
  }
}
