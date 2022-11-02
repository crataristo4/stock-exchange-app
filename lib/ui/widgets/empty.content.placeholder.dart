import 'package:flutter/material.dart';
import 'package:stock_exchange_app/utils/extensions.dart';

import 'button.dart';

/// placeholder for empty pages
class EmptyContentPlaceholder extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String subtitle;
  final void Function()? onRetry;
  final String retryButtonText;

  const EmptyContentPlaceholder({
    Key? key,
    required this.title,
    required this.subtitle,
    this.onRetry,
    this.icon,
    this.retryButtonText = 'Try again',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (icon != null)
                Icon(
                  // FontAwesomeIcons.globe,
                  icon,
                  color: context.colorScheme.error,
                  size: context.width * 0.25,
                ),
              const SizedBox(height: 24),
              Text(
                title,
                style: context.textTheme.headline6?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.error,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                subtitle,
                style: context.textTheme.subtitle1,
                textAlign: TextAlign.center,
              ),
              if (onRetry != null)
                RoundedButton(
                  text: retryButtonText,
                  onTap: onRetry!,
                ),
            ],
          ),
        ),
      );
}
