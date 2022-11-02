import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:stock_exchange_app/data/entities/stock.dart';
import 'package:stock_exchange_app/data/entities/ticker.dart';
import 'package:stock_exchange_app/ui/manager/market_stack_cubit.dart';
import 'package:stock_exchange_app/ui/widgets/empty.content.placeholder.dart';
import 'package:stock_exchange_app/ui/widgets/loading.overlay.dart';
import 'package:stock_exchange_app/utils/constants.dart';
import 'package:stock_exchange_app/utils/extensions.dart';

class TickerDetailsPage extends StatefulWidget {
  final Ticker ticker;

  const TickerDetailsPage({Key? key, required this.ticker}) : super(key: key);

  @override
  State<TickerDetailsPage> createState() => _TickerDetailsPageState();
}

class _TickerDetailsPageState extends State<TickerDetailsPage> {
  var _loading = true, _stocks = List<Stock>.empty();
  final _cubit = MarketStackCubit();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 550)).then((value) =>
        _cubit.getEndOfDayDataForStockTickers(symbol: widget.ticker.symbol));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _cubit,
      listener: (context, state) {
        if (!mounted) return;

        setState(() => _loading = state is MarketStackLoading);

        if (state is MarketStackError) {
          context.showSnackbar(state.message, asError: true);
        }

        if (state is MarketStackSuccess<List<Stock>>) {
          setState(() => _stocks = state.data);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(widget.ticker.name)),
        body: LoadingOverlay(
          loading: _loading,
          child: _stocks.isEmpty
              ? EmptyContentPlaceholder(
                  title: kErrorMessage,
                  subtitle:
                      'Sorry...there are no stocks to display at the moment',
                  onRetry: _cubit.getTickers,
                  icon: Entypo.globe,
                )
              : Column(
                  children: [
                    Container(
                      width: context.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 40),
                      margin: const EdgeInsets.fromLTRB(0, 12, 0, 16),
                      decoration: BoxDecoration(
                        color: context.colorScheme.secondary,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // open & close
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Open',
                                      style:
                                          context.textTheme.subtitle1?.copyWith(
                                        color: context.colorScheme.onSecondary
                                            .withOpacity(0.9),
                                      ),
                                    ),
                                    Text(
                                      formatAmount(_stocks.first.open),
                                      style:
                                          context.textTheme.subtitle1?.copyWith(
                                        color: context.colorScheme.onSecondary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Close',
                                      style:
                                          context.textTheme.subtitle1?.copyWith(
                                        color: context.colorScheme.onSecondary
                                            .withOpacity(0.9),
                                      ),
                                    ),
                                    Text(
                                      formatAmount(_stocks.first.close),
                                      style:
                                          context.textTheme.subtitle1?.copyWith(
                                        color: context.colorScheme.onSecondary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          // high & low
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'High',
                                      style:
                                          context.textTheme.subtitle1?.copyWith(
                                        color: context.colorScheme.onSecondary
                                            .withOpacity(0.9),
                                      ),
                                    ),
                                    Text(
                                      formatAmount(_stocks.first.high),
                                      style:
                                          context.textTheme.subtitle1?.copyWith(
                                        color: context.colorScheme.onSecondary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Low',
                                      style:
                                          context.textTheme.subtitle1?.copyWith(
                                        color: context.colorScheme.onSecondary
                                            .withOpacity(0.9),
                                      ),
                                    ),
                                    Text(
                                      formatAmount(_stocks.first.low),
                                      style:
                                          context.textTheme.subtitle1?.copyWith(
                                        color: context.colorScheme.onSecondary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          // adjusted high & low
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Adj. High',
                                      style:
                                          context.textTheme.subtitle1?.copyWith(
                                        color: context.colorScheme.onSecondary
                                            .withOpacity(0.9),
                                      ),
                                    ),
                                    Text(
                                      formatAmount(_stocks.first.adjustedHigh),
                                      style:
                                          context.textTheme.subtitle1?.copyWith(
                                        color: context.colorScheme.onSecondary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Adj. Low',
                                      style:
                                          context.textTheme.subtitle1?.copyWith(
                                        color: context.colorScheme.onSecondary
                                            .withOpacity(0.9),
                                      ),
                                    ),
                                    Text(
                                      formatAmount(_stocks.first.adjustedLow),
                                      style:
                                          context.textTheme.subtitle1?.copyWith(
                                        color: context.colorScheme.onSecondary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(bottom: 40),
                        itemBuilder: (context, index) {
                          var stock = _stocks[index];
                          return ListTile(
                            title: Text(stock.exchange),
                            // subtitle: Text(ticker.stockExchange.website),
                            trailing: IconButton(
                              onPressed: () async {
                                // if (await canLaunch(
                                //     ticker.stockExchange.website)) {
                                //   await launch(ticker.stockExchange.website);
                                // }
                              },
                              icon: const Icon(Entypo.globe),
                              color: context.colorScheme.onSecondary,
                            ),
                            // onTap: () => context.router
                            //     .push(TickerDetailsRoute(ticker: ticker)),
                          );
                        },
                        separatorBuilder: (_, __) =>
                            const Divider(endIndent: 24),
                        itemCount: _stocks.length,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
