// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_recomendation_product_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRecomendationProductResponseModel
    _$GetRecomendationProductResponseModelFromJson(Map<String, dynamic> json) =>
        GetRecomendationProductResponseModel(
          statusCode: (json['statusCode'] as num).toInt(),
          message: json['message'] as String,
          data: Data.fromJson(json['data'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$GetRecomendationProductResponseModelToJson(
        GetRecomendationProductResponseModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: json['id'] as String,
      acneScore: json['acne_score'] as String,
      flexScore: json['flex_score'] as String,
      wrinkleScore: json['wrinkle_score'] as String,
      mainCondition: json['main_condition'] as String,
      products: (json['products'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'acne_score': instance.acneScore,
      'flex_score': instance.flexScore,
      'wrinkle_score': instance.wrinkleScore,
      'main_condition': instance.mainCondition,
      'products': instance.products,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as String,
      name: json['name'] as String,
      linkProduct: json['link_product'] as String,
      price: json['price'] as String,
      rating: (json['rating'] as num).toDouble(),
      shop: json['shop'] as String,
      image: json['image'] as String,
      sold: json['sold'] as String,
      category: json['category'] as String,
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
      'category': instance.category,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
