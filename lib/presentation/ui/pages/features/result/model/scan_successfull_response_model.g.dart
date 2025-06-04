// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_successfull_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScanSuccesfullResponseModel _$ScanSuccesfullResponseModelFromJson(
        Map<String, dynamic> json) =>
    ScanSuccesfullResponseModel(
      id: json['id'] as String,
      acneScore: json['acne_score'] as String,
      flexScore: json['flex_score'] as String,
      wrinkleScore: json['wrinkle_score'] as String,
      mainCondition: json['main_condition'] as String,
    );

Map<String, dynamic> _$ScanSuccesfullResponseModelToJson(
        ScanSuccesfullResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'acne_score': instance.acneScore,
      'flex_score': instance.flexScore,
      'wrinkle_score': instance.wrinkleScore,
      'main_condition': instance.mainCondition,
    };
