import 'package:json_annotation/json_annotation.dart';
part 'routine.g.dart';
@JsonSerializable()
class Routine {
    @JsonKey(name: "id")
    int id;
    @JsonKey(name: "image")
    String image;
    @JsonKey(name: "activity")
    String activity;
    @JsonKey(name: "is_comlete")
    bool isComlete;

    Routine({
        required this.id,
        required this.image,
        required this.activity,
        required this.isComlete,
    });

    factory Routine.fromJson(Map<String, dynamic> json) => _$RoutineFromJson(json);

    Map<String, dynamic> toJson() => _$RoutineToJson(this);
}
