import 'package:json_annotation/json_annotation.dart';

part 'stock.exchange.g.dart';

@JsonSerializable()
class StockExchange {
  final String name;
  final String acronym;
  @JsonKey(name: 'mic')
  final String symbol;
  final String country;
  final String city;
  final String website;

  const StockExchange({
    required this.name,
    required this.acronym,
    required this.symbol,
    required this.country,
    required this.city,
    required this.website,
  });

  factory StockExchange.fromJson(json) => _$StockExchangeFromJson(json);

  Map<String, dynamic> toJson() => _$StockExchangeToJson(this);
}

/// converter to/from json
class StockExchangeConverter
    implements JsonConverter<StockExchange, Map<String, dynamic>> {
  const StockExchangeConverter();

  @override
  StockExchange fromJson(Map<String, dynamic> json) =>
      StockExchange.fromJson(json);

  @override
  Map<String, dynamic> toJson(StockExchange object) => object.toJson();
}
