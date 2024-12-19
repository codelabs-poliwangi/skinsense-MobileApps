import 'package:json_annotation/json_annotation.dart';
part 'products.g.dart';
@JsonSerializable()
class Products {
    @JsonKey(name: "statusCode")
    final int statusCode;
    @JsonKey(name: "message")
    final String message;
    @JsonKey(name: "data")
    final List<Datum> data;
    @JsonKey(name: "meta")
    final Meta meta;

    Products({
        required this.statusCode,
        required this.message,
        required this.data,
        required this.meta,
    });

    Products copyWith({
        int? statusCode,
        String? message,
        List<Datum>? data,
        Meta? meta,
    }) => 
        Products(
            statusCode: statusCode ?? this.statusCode,
            message: message ?? this.message,
            data: data ?? this.data,
            meta: meta ?? this.meta,
        );

    factory Products.fromJson(Map<String, dynamic> json) => _$ProductsFromJson(json);

    Map<String, dynamic> toJson() => _$ProductsToJson(this);
}

@JsonSerializable()
class Datum {
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

    Datum({
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

    Datum copyWith({
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
        Datum(
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

    factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

    Map<String, dynamic> toJson() => _$DatumToJson(this);
}


@JsonSerializable()
class Meta {
    @JsonKey(name: "page")
    final int page;
    @JsonKey(name: "limit")
    final int limit;
    @JsonKey(name: "productsCount")
    final int productsCount;
    @JsonKey(name: "pageCount")
    final int pageCount;
    @JsonKey(name: "hasPreviousPage")
    final bool hasPreviousPage;
    @JsonKey(name: "hasNextPage")
    final bool hasNextPage;

    Meta({
        required this.page,
        required this.limit,
        required this.productsCount,
        required this.pageCount,
        required this.hasPreviousPage,
        required this.hasNextPage,
    });

    Meta copyWith({
        int? page,
        int? limit,
        int? productsCount,
        int? pageCount,
        bool? hasPreviousPage,
        bool? hasNextPage,
    }) => 
        Meta(
            page: page ?? this.page,
            limit: limit ?? this.limit,
            productsCount: productsCount ?? this.productsCount,
            pageCount: pageCount ?? this.pageCount,
            hasPreviousPage: hasPreviousPage ?? this.hasPreviousPage,
            hasNextPage: hasNextPage ?? this.hasNextPage,
        );

    factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

    Map<String, dynamic> toJson() => _$MetaToJson(this);
}
