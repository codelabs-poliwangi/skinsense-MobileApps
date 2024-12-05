import 'package:json_annotation/json_annotation.dart';
part 'skin_condition.g.dart';
@JsonSerializable()
class SkinCondition {
    @JsonKey(name: "id")
    final int id;
    @JsonKey(name: "acne")
    final int acne;
    @JsonKey(name: "flex")
    final int flex;
    @JsonKey(name: "wringkle")
    final int wringkle;
    @JsonKey(name: "last_check")
    final String lastCheck;

    SkinCondition({
        required this.id,
        required this.acne,
        required this.flex,
        required this.wringkle,
        required this.lastCheck,
    });

    SkinCondition copyWith({
        int? id,
        int? acne,
        int? flex,
        int? wringkle,
        String? lastCheck,
    }) => 
        SkinCondition(
            id: id ?? this.id,
            acne: acne ?? this.acne,
            flex: flex ?? this.flex,
            wringkle: wringkle ?? this.wringkle,
            lastCheck: lastCheck ?? this.lastCheck,
        );

    factory SkinCondition.fromJson(Map<String, dynamic> json) => _$SkinConditionFromJson(json);

    Map<String, dynamic> toJson() => _$SkinConditionToJson(this);
}
