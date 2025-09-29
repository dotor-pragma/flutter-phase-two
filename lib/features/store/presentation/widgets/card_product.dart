import 'package:flutter/material.dart';

import 'package:fase_2/features/store/domain/entities/product_entity.dart';

class CardProduct extends StatelessWidget {
  const CardProduct({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      shadowColor: theme.colorScheme.primary.withValues(alpha: 0.5),
      child: Column(
        children: [
          _ImageCard(
            imageUrl: product.image,
            backgroundColor: theme.colorScheme.secondary,
          ),
          _BodyCard(product: product, theme: theme),
        ],
      ),
    );
  }
}

class _BodyCard extends StatelessWidget {
  const _BodyCard({required this.product, required this.theme});

  final ProductEntity product;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 6),
          Text(
            product.category,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${product.price.toStringAsFixed(2)}",
                style: theme.textTheme.titleLarge,
              ),
              Row(
                children: [
                  const Icon(Icons.star_rounded, size: 14, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text(
                    product.rating.rate.toStringAsFixed(1),
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ImageCard extends StatelessWidget {
  const _ImageCard({required this.imageUrl, required this.backgroundColor});

  final String imageUrl;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: AspectRatio(aspectRatio: 1.6, child: Image.network(imageUrl)),
        ),
      ),
    );
  }
}
