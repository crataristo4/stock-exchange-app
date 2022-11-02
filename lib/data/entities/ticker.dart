import 'package:json_annotation/json_annotation.dart';
import 'package:stock_exchange_app/data/entities/stock.exchange.dart';

part 'ticker.g.dart';

/// stock ticker scaffolding
@JsonSerializable(createToJson: false)
class Ticker {
  final String name;
  final String symbol;
  @JsonKey(name: 'has_eod')
  final bool hasEndOfDayData;
  @StockExchangeConverter()
  @JsonKey(name: 'stock_exchange')
  final StockExchange stockExchange;

  const Ticker({
    required this.name,
    required this.symbol,
    required this.hasEndOfDayData,
    required this.stockExchange,
  });

  factory Ticker.fromJson(json) => _$TickerFromJson(json);
}
