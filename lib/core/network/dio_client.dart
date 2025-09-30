import 'package:dio/dio.dart';
import 'package:fase_2/core/network/api_config.dart';

class DioClient {
  final Dio dio;

  DioClient._internal() : dio = Dio(BaseOptions(baseUrl: ApiConfig.baseUrl));

  static final DioClient _instance = DioClient._internal();

  factory DioClient() => _instance;
}
