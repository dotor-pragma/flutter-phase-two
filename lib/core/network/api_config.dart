import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static final baseUrl = dotenv.env['BASE_URL'] ?? 'https://fakestoreapi.com';

  static const products = '/products';
  static const users = '/users';
  static const carts = '/carts';
}
