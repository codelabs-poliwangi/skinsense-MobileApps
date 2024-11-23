import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';
@JsonSerializable()
class User {
    @JsonKey(name: "statusCode")
    final int statusCode;
    @JsonKey(name: "message")
    final String message;
    @JsonKey(name: "data")
    final Data data;

    User({
        required this.statusCode,
        required this.message,
        required this.data,
    });

    User copyWith({
        int? statusCode,
        String? message,
        Data? data,
    }) => 
        User(
            statusCode: statusCode ?? this.statusCode,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

    Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Data {
    @JsonKey(name: "id")
    final String id;
    @JsonKey(name: "email")
    final String email;
    @JsonKey(name: "name")
    final String name;
    @JsonKey(name: "phone")
    final String phone;

    Data({
        required this.id,
        required this.email,
        required this.name,
        required this.phone,
    });

    Data copyWith({
        String? id,
        String? email,
        String? name,
        String? phone,
    }) => 
        Data(
            id: id ?? this.id,
            email: email ?? this.email,
            name: name ?? this.name,
            phone: phone ?? this.phone,
        );

    factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

    Map<String, dynamic> toJson() => _$DataToJson(this);
}
