// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WanResponse<T> _$WanResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    WanResponse<T>(
      json['errorCode'] as int,
      json['errorMsg'] as String,
      fromJsonT(json['data']),
    );

Map<String, dynamic> _$WanResponseToJson<T>(
  WanResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
      'data': toJsonT(instance.data),
    };
