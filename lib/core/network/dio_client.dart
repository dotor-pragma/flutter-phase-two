import 'package:dio/dio.dart';
import 'package:fase_2/core/network/api_config.dart';

class DioClient {
  static final Dio dio = Dio(BaseOptions(baseUrl: ApiConfig.baseUrl));
}
