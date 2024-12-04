import 'package:json_annotation/json_annotation.dart';
part 'product.g.dart';
@JsonSerializable()
class Product {
    @JsonKey(name: "id")
    final String id;
    @JsonKey(name: "name")
    final String name;
    @JsonKey(name: "link_product")
    final String linkProduct;
    @JsonKey(name: "price")
    final String price;
    @JsonKey(name: "rating")
    final double? rating;
    @JsonKey(name: "shop")
    final String shop;
    @JsonKey(name: "image")
    final String image;
    @JsonKey(name: "sold")
    final String sold;
    @JsonKey(name: "category")
    final String category;
    @JsonKey(name: "createdAt")
    final DateTime createdAt;
    @JsonKey(name: "updatedAt")
    final DateTime updatedAt;

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

    Product copyWith({
        String? id,
        String? name,
        String? linkProduct,
        String? price,
        double? rating,
        String? shop,
        String? image,
        String? sold,
        String? category,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        Product(
            id: id ?? this.id,
            name: name ?? this.name,
            linkProduct: linkProduct ?? this.linkProduct,
            price: price ?? this.price,
            rating: rating ?? this.rating,
            shop: shop ?? this.shop,
            image: image ?? this.image,
            sold: sold ?? this.sold,
            category: category ?? this.category,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

    Map<String, dynamic> toJson() => _$ProductToJson(this);
}
