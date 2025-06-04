import 'package:json_annotation/json_annotation.dart';
part 'get_recomendation_product_response_model.g.dart';
@JsonSerializable()
class GetRecomendationProductResponseModel {
    @JsonKey(name: "statusCode")
    int statusCode;
    @JsonKey(name: "message")
    String message;
    @JsonKey(name: "data")
    Data data;

    GetRecomendationProductResponseModel({
        required this.statusCode,
        required this.message,
        required this.data,
    });

    factory GetRecomendationProductResponseModel.fromJson(Map<String, dynamic> json) => _$GetRecomendationProductResponseModelFromJson(json);

    Map<String, dynamic> toJson() => _$GetRecomendationProductResponseModelToJson(this);
}

@JsonSerializable()
class Data {
    @JsonKey(name: "id")
    String id;
    @JsonKey(name: "acne_score")
    String acneScore;
    @JsonKey(name: "flex_score")
    String flexScore;
    @JsonKey(name: "wrinkle_score")
    String wrinkleScore;
    @JsonKey(name: "main_condition")
    String mainCondition;
    @JsonKey(name: "products")
    List<Product> products;

    Data({
        required this.id,
        required this.acneScore,
        required this.flexScore,
        required this.wrinkleScore,
        required this.mainCondition,
        required this.products,
    });

    factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

    Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Product {
    @JsonKey(name: "id")
    String id;
    @JsonKey(name: "name")
    String name;
    @JsonKey(name: "link_product")
    String linkProduct;
    @JsonKey(name: "price")
    String price;
    @JsonKey(name: "rating")
    double rating;
    @JsonKey(name: "shop")
    String shop;
    @JsonKey(name: "image")
    String image;
    @JsonKey(name: "sold")
    String sold;
    @JsonKey(name: "category")
    String category;
    @JsonKey(name: "createdAt")
    DateTime createdAt;
    @JsonKey(name: "updatedAt")
    DateTime updatedAt;

    Product({
        required this.id,
        required this.name,
        required this.linkProduct,
        required this.price,
        required this.rating,
        required this.shop,
        required this.image,
        required this.sold,
        required this.category,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

    Map<String, dynamic> toJson() => _$ProductToJson(this);
}
