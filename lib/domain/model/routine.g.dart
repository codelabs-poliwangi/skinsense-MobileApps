// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Routine _$RoutineFromJson(Map<String, dynamic> json) => Routine(
      id: (json['id'] as num).toInt(),
      image: json['image'] as String,
      activity: json['activity'] as String,
      isComplete: json['is_comlete'] as bool,
    );

Map<String, dynamic> _$RoutineToJson(Routine instance) => <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'activity': instance.activity,
      'is_comlete': instance.isComplete,
    };
