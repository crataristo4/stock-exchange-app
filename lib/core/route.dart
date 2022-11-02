import 'package:auto_route/annotations.dart';
import 'package:stock_exchange_app/ui/pages/home.dart';
import 'package:stock_exchange_app/ui/pages/ticker.details.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(page: HomePage, initial: true),
    AutoRoute(page: TickerDetailsPage, initial: true),
  ],
)
class $AppRouter {}
