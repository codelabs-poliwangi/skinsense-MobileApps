import 'package:json_annotation/json_annotation.dart';
part 'routine.g.dart';
@JsonSerializable()
class Routine {
    @JsonKey(name: "id")
    final int id;
    @JsonKey(name: "image")
    final String image;
    @JsonKey(name: "activity")
    final String activity;
    @JsonKey(name: "is_comlete")
    final bool isComlete;

    Routine({
        required this.id,
        required this.image,
        required this.activity,
        required this.isComlete,
    });

    Routine copyWith({
        int? id,
        String? image,
        String? activity,
        bool? isComlete,
    }) => 
        Routine(
            id: id ?? this.id,
            image: image ?? this.image,
            activity: activity ?? this.activity,
            isComlete: isComlete ?? this.isComlete,
        );

    factory Routine.fromJson(Map<String, dynamic> json) => _$RoutineFromJson(json);

    Map<String, dynamic> toJson() => _$RoutineToJson(this);
}
