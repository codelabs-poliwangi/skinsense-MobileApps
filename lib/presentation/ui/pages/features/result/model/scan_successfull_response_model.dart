import 'package:json_annotation/json_annotation.dart';
part 'scan_successfull_response_model.g.dart';

@JsonSerializable()
class ScanSuccesfullResponseModel {
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

    ScanSuccesfullResponseModel({
        required this.id,
        required this.acneScore,
        required this.flexScore,
        required this.wrinkleScore,
        required this.mainCondition,
    });

    factory ScanSuccesfullResponseModel.fromJson(Map<String, dynamic> json) => _$ScanSuccesfullResponseModelFromJson(json);

    Map<String, dynamic> toJson() => _$ScanSuccesfullResponseModelToJson(this);
}
