// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:stock_exchange_app/data/entities/ticker.dart' as _i5;
import 'package:stock_exchange_app/ui/pages/home.dart' as _i1;
import 'package:stock_exchange_app/ui/pages/ticker.details.dart' as _i2;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i1.HomePage(),
      );
    },
    TickerDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<TickerDetailsRouteArgs>();
      return _i3.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i2.TickerDetailsPage(
          key: args.key,
          ticker: args.ticker,
        ),
      );
    },
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(
          HomeRoute.name,
          path: '/',
        ),
        _i3.RouteConfig(
          TickerDetailsRoute.name,
          path: '/',
        ),
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i3.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.TickerDetailsPage]
class TickerDetailsRoute extends _i3.PageRouteInfo<TickerDetailsRouteArgs> {
  TickerDetailsRoute({
    _i4.Key? key,
    required _i5.Ticker ticker,
  }) : super(
          TickerDetailsRoute.name,
          path: '/',
          args: TickerDetailsRouteArgs(
            key: key,
            ticker: ticker,
          ),
        );

  static const String name = 'TickerDetailsRoute';
}

class TickerDetailsRouteArgs {
  const TickerDetailsRouteArgs({
    this.key,
    required this.ticker,
  });

  final _i4.Key? key;

  final _i5.Ticker ticker;

  @override
  String toString() {
    return 'TickerDetailsRouteArgs{key: $key, ticker: $ticker}';
  }
}
