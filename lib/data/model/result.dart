import 'package:collection/collection.dart';

class Result<T> {
  Result._();

  factory Result.loading(T msg) = LoadingState<T>;

  factory Result.success(T value) = SuccessState<T>;

  factory Result.error(String msg) = ErrorState<T>;
}

class LoadingState<T> extends Result<T> {
  LoadingState(this.msg) : super._();
  final T msg;

  @override
  int get hashCode => msg.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is LoadingState && msg == other.msg;
}

class ErrorState<T> extends Result<T> {
  ErrorState(this.msg) : super._();
  final String msg;

  @override
  int get hashCode => msg.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ErrorState && msg == other.msg;
}

class SuccessState<T> extends Result<T> {
  SuccessState(this.value) : super._();
  T value;

  bool _areValuesEqual(T valueA, T valueB) {
    if (valueA is List && valueB is List) {
      return ListEquality().equals(valueA, valueB);
    }
    return valueA == valueB;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SuccessState && _areValuesEqual(value, other.value);
}
