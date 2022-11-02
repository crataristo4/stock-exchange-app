part of 'market_stack_cubit.dart';

@immutable
abstract class MarketStackState {
  const MarketStackState();
}

class MarketStackInitial extends MarketStackState {}

class MarketStackLoading extends MarketStackState {}

class MarketStackSuccess<T> extends MarketStackState {
  final T data;

  const MarketStackSuccess(this.data);
}

class MarketStackError extends MarketStackState {
  final String message;

  const MarketStackError(this.message);
}
