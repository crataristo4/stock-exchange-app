import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:stock_exchange_app/core/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterConfig.loadEnvVariables();

  runApp(const BasaltApp());
}
