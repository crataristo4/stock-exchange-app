// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticker _$TickerFromJson(Map<String, dynamic> json) => Ticker(
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      hasEndOfDayData: json['has_eod'] as bool,
      stockExchange: const StockExchangeConverter()
          .fromJson(json['stock_exchange'] as Map<String, dynamic>),
    );
