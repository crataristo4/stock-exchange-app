// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stock _$StockFromJson(Map<String, dynamic> json) => Stock(
      symbol: json['symbol'] as String,
      exchange: json['exchange'] as String,
      date: json['date'] as String,
      open: (json['open'] as num).toDouble(),
      high: (json['high'] as num).toDouble(),
      low: (json['low'] as num).toDouble(),
      close: (json['close'] as num).toDouble(),
      adjustedHigh: (json['adj_high'] as num).toDouble(),
      adjustedLow: (json['adj_low'] as num).toDouble(),
      adjustedClose: (json['adj_close'] as num).toDouble(),
      adjustedOpen: (json['adj_open'] as num).toDouble(),
      volume: (json['volume'] as num).toDouble(),
      adjustedVolume: (json['adj_volume'] as num).toDouble(),
    );
