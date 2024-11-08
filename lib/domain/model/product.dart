import 'package:json_annotation/json_annotation.dart';
part 'product.g.dart';
@JsonSerializable()
class Product {
    @JsonKey(name: "id")
    final int id;
    @JsonKey(name: "link")
    final String link;
    @JsonKey(name: "name")
    final String name;
    @JsonKey(name: "price")
    final int price;
    @JsonKey(name: "store")
    final String store;
    @JsonKey(name: "rating")
    final int rating;
    @JsonKey(name: "product_image")
    final String productImage;

    Product({
        required this.id,
        required this.link,
        required this.name,
        required this.price,
        required this.store,
        required this.rating,
        required this.productImage,
    });

    Product copyWith({
        int? id,
        String? link,
        String? name,
        int? price,
        String? store,
        int? rating,
        String? productImage,
    }) => 
        Product(
            id: id ?? this.id,
            link: link ?? this.link,
            name: name ?? this.name,
            price: price ?? this.price,
            store: store ?? this.store,
            rating: rating ?? this.rating,
            productImage: productImage ?? this.productImage,
        );

    factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

    Map<String, dynamic> toJson() => _$ProductToJson(this);
}
