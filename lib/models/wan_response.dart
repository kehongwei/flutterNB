import 'package:json_annotation/json_annotation.dart';
part 'wan_response.g.dart';
@JsonSerializable(genericArgumentFactories: true)
class WanResponse<T>{

   int errorCode;
   String errorMsg;
   T data;

   WanResponse(this.errorCode, this.errorMsg, this.data);

  factory WanResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) => _$WanResponseFromJson(json,fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$WanResponseToJson(this,toJsonT);

}