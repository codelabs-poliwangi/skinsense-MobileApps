// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: (json['id'] as num).toInt(),
      link: json['link'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toInt(),
      store: json['store'] as String,
      rating: (json['rating'] as num).toInt(),
      productImage: json['product_image'] as String,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'link': instance.link,
      'name': instance.name,
      'price': instance.price,
      'store': instance.store,
      'rating': instance.rating,
      'product_image': instance.productImage,
    };
