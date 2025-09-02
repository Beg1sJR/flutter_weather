part of 'weather_details_bloc.dart';

@immutable
sealed class WeatherDetailsState extends Equatable {}

final class WeatherDetailsInitial extends WeatherDetailsState {
  @override
  List<Object?> get props => [];
}

final class WeatherDetailsLoading extends WeatherDetailsState {
  @override
  List<Object?> get props => [];
}

final class WeatherDetailsLoaded extends WeatherDetailsState {
  final WeatherModel weatherDetails;

  WeatherDetailsLoaded(this.weatherDetails);

  @override
  List<Object?> get props => [weatherDetails];
}

final class WeatherDetailsError extends WeatherDetailsState {
  final String message;

  WeatherDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}
