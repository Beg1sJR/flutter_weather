part of 'forecast_bloc.dart';

@immutable
sealed class ForecastState extends Equatable {}

final class ForecastInitial extends ForecastState {
  @override
  List<Object?> get props => [];
}

final class ForecastLoading extends ForecastState {
  @override
  List<Object?> get props => [];
}

final class ForecastLoaded extends ForecastState {
  final ForecastWeatherModel forecastDetails;

  ForecastLoaded(this.forecastDetails);

  @override
  List<Object?> get props => [forecastDetails];
}

final class ForecastError extends ForecastState {
  final String message;

  ForecastError({required this.message});

  @override
  List<Object?> get props => [message];
}
