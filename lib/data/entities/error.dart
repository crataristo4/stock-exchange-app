import 'package:json_annotation/json_annotation.dart';

part 'error.g.dart';

/// API error message scaffolding
@JsonSerializable()
class ApiError {
  final String code;
  final String message;

  const ApiError({required this.code, required this.message});

  /// parses error message from json
  factory ApiError.fromJson(json) => _$ApiErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorToJson(this);
}

/// converter to/from json
class ApiErrorConverter implements JsonConverter<ApiError?, Map<String, dynamic>?> {
  const ApiErrorConverter();

  @override
  ApiError? fromJson(Map<String, dynamic>? json) => json == null ? null : ApiError.fromJson(json);

  @override
  Map<String, dynamic>? toJson(ApiError? object) => object?.toJson();

}