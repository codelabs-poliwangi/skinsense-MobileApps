// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as String,
      name: json['name'] as String,
      linkProduct: json['link_product'] as String,
      price: json['price'] as String,
      rating: (json['rating'] as num?)?.toDouble(),
      shop: json['shop'] as String,
      image: json['image'] as String,
      sold: json['sold'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'link_product': instance.linkProduct,
      'price': instance.price,
      'rating': instance.rating,
      'shop': instance.shop,
      'image': instance.image,
      'sold': instance.sold,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
