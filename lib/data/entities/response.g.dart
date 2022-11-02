// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse _$ApiResponseFromJson(Map<String, dynamic> json) => ApiResponse(
      error: const ApiErrorConverter()
          .fromJson(json['error'] as Map<String, dynamic>?),
      data: json['data'],
    );

Map<String, dynamic> _$ApiResponseToJson(ApiResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'error': const ApiErrorConverter().toJson(instance.error),
    };
