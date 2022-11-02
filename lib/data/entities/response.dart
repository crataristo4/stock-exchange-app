import 'package:json_annotation/json_annotation.dart';
import 'package:stock_exchange_app/data/entities/error.dart';

part 'response.g.dart';

/// API response for successful calls to the server
@JsonSerializable()
class ApiResponse {
  final dynamic data;

  @ApiErrorConverter()
  @JsonKey(name: "error")
  final ApiError? error;

  const ApiResponse({this.error, this.data});

  /// parses error message from json
  factory ApiResponse.fromJson(json) => _$ApiResponseFromJson(json);

  @override
  String toString() => _$ApiResponseToJson(this).toString();
}
