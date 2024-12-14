// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Products _$ProductsFromJson(Map<String, dynamic> json) => Products(
      statusCode: (json['statusCode'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductsToJson(Products instance) => <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
      'meta': instance.meta,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: json['id'] as String,
      name: json['name'] as String,
      linkProduct: json['link_product'] as String,
      price: json['price'] as String,
      rating: (json['rating'] as num?)?.toDouble(),
      shop: json['shop'] as String,
      image: json['image'] as String,
      sold: json['sold'] as String,
      category: json['category'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'link_product': instance.linkProduct,
      'price': instance.price,
      'rating': instance.rating,
      'shop': instance.shop,
      'image': instance.image,
      'sold': instance.sold,
      'category': instance.category,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      page: (json['page'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
      productsCount: (json['productsCount'] as num).toInt(),
      pageCount: (json['pageCount'] as num).toInt(),
      hasPreviousPage: json['hasPreviousPage'] as bool,
      hasNextPage: json['hasNextPage'] as bool,
    );

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
      'productsCount': instance.productsCount,
      'pageCount': instance.pageCount,
      'hasPreviousPage': instance.hasPreviousPage,
      'hasNextPage': instance.hasNextPage,
    };
