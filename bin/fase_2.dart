import 'dart:io';

import 'package:fase_2/core/network/dio_client.dart';
import 'package:fase_2/domain/usecases/products_usecase.dart';
import 'package:fase_2/infrastructure/datasources/remote_products_datasource_impl.dart';
import 'package:fase_2/infrastructure/repositories_impl/product_repository_impl.dart';
import 'package:fase_2/presentation/cli/store_cli_presenter.dart';

Future<void> main(List<String> arguments) async {
  final dio = DioClient().dio;
  final repository = ProductRepositoryImpl(
    datasource: RemoteProductsDatasourceImpl(dio),
  );
  final getAllProductsUseCase = GetAllProductsUseCase(
    productRepository: repository,
  );

  final presenter = StoreCliPresenter(
    getAllProductsUseCase: getAllProductsUseCase,
  );

  await presenter.fetchAndPrintProducts();
  exit(0);
}
