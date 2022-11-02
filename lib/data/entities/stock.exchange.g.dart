// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock.exchange.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockExchange _$StockExchangeFromJson(Map<String, dynamic> json) =>
    StockExchange(
      name: json['name'] as String,
      acronym: json['acronym'] as String,
      symbol: json['mic'] as String,
      country: json['country'] as String,
      city: json['city'] as String,
      website: json['website'] as String,
    );

Map<String, dynamic> _$StockExchangeToJson(StockExchange instance) =>
    <String, dynamic>{
      'name': instance.name,
      'acronym': instance.acronym,
      'mic': instance.symbol,
      'country': instance.country,
      'city': instance.city,
      'website': instance.website,
    };
