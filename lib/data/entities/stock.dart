import 'package:json_annotation/json_annotation.dart';

part 'stock.g.dart';

@JsonSerializable(createToJson: false)
class Stock {
  final String symbol;
  final String exchange;
  final String date;
  final double open;
  final double high;
  final double low;
  final double close;
  @JsonKey(name: 'adj_high')
  final double adjustedHigh;
  @JsonKey(name: 'adj_low')
  final double adjustedLow;
  @JsonKey(name: 'adj_close')
  final double adjustedClose;
  @JsonKey(name: 'adj_open')
  final double adjustedOpen;
  final double volume;
  @JsonKey(name: 'adj_volume')
  final double adjustedVolume;

  const Stock({
    required this.symbol,
    required this.exchange,
    required this.date,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.adjustedHigh,
    required this.adjustedLow,
    required this.adjustedClose,
    required this.adjustedOpen,
    required this.volume,
    required this.adjustedVolume,
  });

  factory Stock.fromJson(json) => _$StockFromJson(json);
}
