import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:fase_2/features/store/infrastructure/datasources/remote_products_datasource_impl.dart';
//import 'package:fase_2/features/store/infrastructure/datasources/local_products_datasource_impl.dart';
import 'package:fase_2/features/store/infrastructure/repositories_impl/product_repository_impl.dart';
import 'package:fase_2/features/store/presentation/providers/store_provider.dart';
import 'package:fase_2/features/store/presentation/screens/home_screen.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static final ProductRepositoryImpl _productRepository = ProductRepositoryImpl(
    datasource: RemoteProductsDatasourceImpl(),
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              StoreProvider(productRepository: _productRepository)
                ..getAllProducts(),
        ),
      ],
      child: MaterialApp(
        title: 'Fase 2',
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}
