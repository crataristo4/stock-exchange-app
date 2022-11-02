import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stock_exchange_app/utils/constants.dart';
import 'package:stock_exchange_app/utils/extensions.dart';

class LoadingOverlay extends StatefulWidget {
  final Widget child;
  final bool loading;
  final String message;

  const LoadingOverlay({
    Key? key,
    required this.child,
    this.loading = false,
    this.message = 'Loading...please wait',
  }) : super(key: key);

  @override
  State<LoadingOverlay> createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay> {
  var _connected = true;
  final _networkConnectivity = Connectivity();
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    _observeInternetState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// child
        Positioned.fill(child: SafeArea(bottom: false, child: widget.child)),

        /// internet connectivity overlay
        AnimatedPositioned(
          bottom: _connected ? -context.height * 0.4 : 0,
          left: 0,
          right: 0,
          duration: const Duration(milliseconds: 850),
          child: Container(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
            decoration: BoxDecoration(
              color: context.colorScheme.error,
              // borderRadius: BorderRadius.circular(12),
            ),
            child: SafeArea(
              top: false,
              child: Text(
                'Internet connection lost. Please reconnect and try again',
                textAlign: TextAlign.center,
                style: context.textTheme.subtitle2?.copyWith(
                  color: context.colorScheme.onError,
                ),
              ),
            ),
          ),
        ),

        /// loading overlay
        if (widget.loading)
          Positioned.fill(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 850),
              height: context.height,
              width: context.width,
              color: context.colorScheme.background.withOpacity(0.85),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LottieBuilder.asset(
                      kLoadingAnimationUrl,
                      repeat: true,
                      height: context.height * 0.4,
                      width: context.width,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      widget.message,
                      style: context.textTheme.subtitle2
                          ?.copyWith(color: context.colorScheme.onBackground),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  /// observe internet connection state
  void _observeInternetState() async {
    var result = await _networkConnectivity.checkConnectivity();
    if (!mounted) return;
    setState(() => _connected = result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile);

    /// observe connection state
    _subscription = _networkConnectivity.onConnectivityChanged.listen((result) {
      if (!mounted) return;
      setState(() => _connected = result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile);
    });
  }
}
