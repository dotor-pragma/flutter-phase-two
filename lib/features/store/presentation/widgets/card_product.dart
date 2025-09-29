import 'package:flutter/material.dart';

import 'package:fase_2/features/store/domain/entities/product_entity.dart';

class CardProduct extends StatelessWidget {
  const CardProduct({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(product.image, height: 100),
          Text(product.title),
          Text(product.price.toString()),
        ],
      ),
    );
  }
}
