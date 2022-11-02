import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// extensions on [BuildContext]
extension ContextX on BuildContext {
  ThemeData get currentTheme => Theme.of(this);

  TextTheme get textTheme => currentTheme.textTheme;

  ColorScheme get colorScheme => currentTheme.colorScheme;

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  double get width => mediaQuery.size.width;

  double get height => mediaQuery.size.height;

  void showSnackbar(String message, {bool asError = false}) => ScaffoldMessenger.of(this)
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: asError ? colorScheme.error : colorScheme.secondary,
        content: Text(
          message,
          style: textTheme.subtitle1?.copyWith(
            color: asError ? colorScheme.onError : colorScheme.onSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );

  String dateFormatter({required String formatType, required DateTime dateTime}) {
    return DateFormat(formatType).format(dateTime);
  }
}
