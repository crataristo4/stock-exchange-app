import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:stock_exchange_app/core/route.gr.dart';
import 'package:stock_exchange_app/data/entities/ticker.dart';
import 'package:stock_exchange_app/ui/manager/market_stack_cubit.dart';
import 'package:stock_exchange_app/ui/widgets/empty.content.placeholder.dart';
import 'package:stock_exchange_app/ui/widgets/loading.overlay.dart';
import 'package:stock_exchange_app/utils/constants.dart';
import 'package:stock_exchange_app/utils/extensions.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _loading = true, _tickers = List<Ticker>.empty();
  final _cubit = MarketStackCubit();
  final dateFromController = TextEditingController();
  final dateToController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _cubit.getTickers();
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

        if (state is MarketStackSuccess<List<Ticker>>) {
          setState(() {
            _tickers = state.data;
          });
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: _loading || _tickers.isEmpty ? null : const Text(kAppName),
        ),
        body: LoadingOverlay(
          loading: _loading,
          child: _tickers.isEmpty
              ? EmptyContentPlaceholder(
                  title: kErrorMessage,
                  subtitle: 'Sorry...there are no stocks to display at the moment',
                  onRetry: _cubit.getTickers,
                  icon: Entypo.globe,
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: Text('Filter by date'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 180,
                          height: 50,
                          child: TextField(
                            controller: dateFromController,
                            onTap: () {
                              selectDate(context: context, controller: dateFromController);
                            },
                            readOnly: true,
                            decoration: const InputDecoration(
                              hintText: 'Date from',
                              suffixIcon: Icon(Icons.calendar_month),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(30))),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(
                                  color: Colors.green,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.red,
                              )),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 180,
                          height: 50,
                          child: TextField(
                            onTap: () {
                              selectDate(context: context, controller: dateToController);
                            },
                            controller: dateToController,
                            readOnly: true,
                            decoration: const InputDecoration(
                              hintText: 'Date to',
                              suffixIcon: Icon(Icons.calendar_month),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(30))),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(
                                  color: Colors.green,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.red,
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: TypeAheadField(
                        textFieldConfiguration: TextFieldConfiguration(
                            autofocus: false,
                            style: const TextStyle(),
                            decoration: InputDecoration(
                                hintText: 'Search for a company',
                                suffixIcon: Icon(
                                  Entypo.search,
                                  color: context.currentTheme.disabledColor,
                                ),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.green,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(30))))),
                        suggestionsCallback: (pattern) async {
                          return _tickers.where((element) => element.name.toLowerCase().contains(pattern.toLowerCase()));
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            leading: const Icon(Entypo.globe),
                            title: Text(suggestion.name),
                          );
                        },
                        onSuggestionSelected: (suggestion) {
                          setState(() {
                            _tickers.firstWhere((element) => element.name.toLowerCase().contains(suggestion.name.toLowerCase()));
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(bottom: 40),
                        itemBuilder: (context, index) {
                          var ticker = _tickers[index];
                          return ListTile(
                            title: Text(ticker.name),
                            subtitle: Text(ticker.stockExchange.website),
                            trailing: IconButton(
                              onPressed: () async {
                                if (await canLaunchUrlString(ticker.symbol)) {
                                  await launchUrlString(ticker.stockExchange.website);
                                }
                              },
                              icon: const Icon(Entypo.globe),
                              color: context.colorScheme.secondary,
                            ),
                            onTap: () => ticker.hasEndOfDayData ? context.router.push(TickerDetailsRoute(ticker: ticker)) : null,
                          );
                        },
                        separatorBuilder: (_, __) => const Divider(endIndent: 24),
                        itemCount: _tickers.length,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  selectDate({required BuildContext context, required TextEditingController controller}) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1980),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
        controller.text = context.dateFormatter(formatType: 'yyyy-MM-dd', dateTime: selectedDate);
      });
    }
  }
}
