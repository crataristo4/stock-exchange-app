import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:stock_exchange_app/data/entities/stock.dart';
import 'package:stock_exchange_app/data/entities/ticker.dart';
import 'package:stock_exchange_app/data/repository/market.stack.dart';

part 'market_stack_state.dart';

class MarketStackCubit extends Cubit<MarketStackState> {
  final _repo = MarketStackRepository();

  MarketStackCubit() : super(MarketStackInitial());

  /// get all tickers
  Future<void> getTickers() async {
    emit(MarketStackLoading());
    var either = await _repo.getTickers();
    either.fold(
      (l) => emit(MarketStackSuccess<List<Ticker>>(l)),
      (r) => emit(MarketStackError(r)),
    );
  }

  Future<void> getEndOfDayDataForStockTickers({required String symbol}) async {
    emit(MarketStackLoading());
    var either = await _repo.getEndOfDayDataForStockTickers(symbol: symbol);
    either.fold(
      (l) => emit(MarketStackSuccess<List<Stock>>(l)),
      (r) => emit(MarketStackError(r)),
    );
  }

  Future<void> search(String query) async {
    emit(MarketStackLoading());
    var either = await _repo.searchTickers(query: query);
    either.fold(
      (l) => emit(MarketStackSuccess<List<Ticker>>(l)),
      (r) => emit(MarketStackError(r)),
    );
  }
}
