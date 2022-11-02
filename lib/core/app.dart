import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stock_exchange_app/core/route.gr.dart';
import 'package:stock_exchange_app/utils/constants.dart';
import 'package:stock_exchange_app/utils/theme.dart';

/// application navigation router
final _appRouter = AppRouter();

/// application instance
class BasaltApp extends StatefulWidget {
  const BasaltApp({Key? key}) : super(key: key);

  @override
  State<BasaltApp> createState() => _BasaltAppState();
}

class _BasaltAppState extends State<BasaltApp> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: kAppName,
      themeMode: ThemeMode.light,
      theme: kApplyCustomTheme(context),
      routeInformationParser: _appRouter.defaultRouteParser(),
      routerDelegate: _appRouter.delegate(),
    );
  }
}
