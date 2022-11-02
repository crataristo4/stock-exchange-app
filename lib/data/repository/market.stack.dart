import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:stock_exchange_app/data/entities/response.dart';
import 'package:stock_exchange_app/data/entities/stock.dart';
import 'package:stock_exchange_app/data/entities/ticker.dart';
import 'package:stock_exchange_app/utils/constants.dart';
import 'package:stock_exchange_app/utils/endpoints.dart';

class MarketStackRepository {
  final _server = Dio(
    BaseOptions(
      baseUrl: kBaseUrl,
      queryParameters: {'access_key': FlutterConfig.get('MARKET_STOCK_API')},
    ),
  );

  /// obtain end-of-day data for one or multiple stock tickers.
  Future<Either<List<Stock>, String>> getEndOfDayDataForStockTickers(
      {String symbol = 'AAPL', String? dateFrom, String? dateTo}) async {
    try {
      var response = await _server.get(
        Endpoints.endOfDay,
        queryParameters: {
          'symbols': symbol,
          'limit': 10,
          'date_from': dateFrom,
          'date_to': dateTo,
        },
      );
      if (response.statusCode == 200 && response.data != null) {
        var apiResponse = ApiResponse.fromJson(response.data);
        var stock = (apiResponse.data as List).map((e) => Stock.fromJson(e)).toList();
        return Left(stock);
      }
      return Right(ApiResponse.fromJson(response.data).error?.message ?? kErrorMessage);
    } on DioError catch (e) {
      if (e.response != null) {
        var apiResponse = ApiResponse.fromJson(e.response!.data);
        if (apiResponse.error != null) {
          return Right(apiResponse.error!.message);
        }
      } else {
        // Error due to setting up or sending the request
        debugPrint('Error sending request!');
        debugPrint(e.message);
      }
      return Right(e.message);
    } on Exception catch (e) {
      debugPrint(e.toString());
      return const Right(kErrorMessage);
    }
  }

  Future<Either<List<Ticker>, String>> getTickers() async {
    try {
      var response = await _server.get(Endpoints.tickers, queryParameters: {'limit': 10});
      if (response.statusCode == 200 && response.data != null) {
        var apiResponse = ApiResponse.fromJson(response.data);
        var tickers = (apiResponse.data as List).map((e) => Ticker.fromJson(e)).toList();
        return Left(tickers);
      }
      return Right(ApiResponse.fromJson(response.data).error?.message ?? kErrorMessage);
    } on DioError catch (e) {
      if (e.response != null) {
        var apiResponse = ApiResponse.fromJson(e.response!.data);
        if (apiResponse.error != null) {
          return Right(apiResponse.error!.message);
        }
      } else {
        // Error due to setting up or sending the request
        debugPrint('Error sending request!');
        debugPrint(e.message);
      }
      return Right(e.message);
    }
  }

  Future<Either<List<Ticker>, String>> searchTickers({required String query}) async {
    try {
      var response = await _server.get(Endpoints.searchTickers);
      if (response.statusCode == 200 && response.data != null) {
        var apiResponse = ApiResponse.fromJson(response.data);
        var tickers = (apiResponse.data as List).map((e) => Ticker.fromJson(e)).toList();
        return Left(tickers);
      }
      return Right(ApiResponse.fromJson(response.data).error?.message ?? kErrorMessage);
    } on DioError catch (e) {
      if (e.response != null) {
        var apiResponse = ApiResponse.fromJson(e.response!.data);
        if (apiResponse.error != null) {
          return Right(apiResponse.error!.message);
        }
      } else {
        // Error due to setting up or sending the request
        debugPrint('Error sending request!');
        debugPrint(e.message);
      }
      return Right(e.message);
    }
  }
}
