// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skinCondition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkinCondition _$SkinConditionFromJson(Map<String, dynamic> json) =>
    SkinCondition(
      id: (json['id'] as num).toInt(),
      acne: (json['acne'] as num).toInt(),
      flex: (json['flex'] as num).toInt(),
      wringkle: (json['wringkle'] as num).toInt(),
      lastCheck: json['last_check'] as String,
    );

Map<String, dynamic> _$SkinConditionToJson(SkinCondition instance) =>
    <String, dynamic>{
      'id': instance.id,
      'acne': instance.acne,
      'flex': instance.flex,
      'wringkle': instance.wringkle,
      'last_check': instance.lastCheck,
    };
