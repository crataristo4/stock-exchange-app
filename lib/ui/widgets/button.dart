import 'package:flutter/material.dart';
import 'package:stock_exchange_app/utils/extensions.dart';

/// custom button
class RoundedButton extends StatelessWidget {
  final String text;
  final void Function() onTap;

  const RoundedButton({Key? key, required this.text, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          margin: const EdgeInsets.only(top: 40),
          decoration: BoxDecoration(
            color: context.colorScheme.secondary,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Text(
            text,
            style: context.textTheme.button
                ?.copyWith(color: context.colorScheme.onSecondary),
          ),
        ),
      );
}
