import 'package:fase_2/features/store/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.title,
    required super.price,
    required super.description,
    required super.category,
    required super.image,
    required super.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final ratingJson = json['rating'] as Map<String, dynamic>?;
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: RatingEntity(
        rate: (ratingJson?['rate'])?.toDouble() ?? 0,
        count: (ratingJson?['count'])?.toInt() ?? 0,
      ),
    );
  }

  ProductEntity toProductEntity() {
    return ProductEntity(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
      rating: RatingEntity(rate: rating.rate, count: rating.count),
    );
  }
}
