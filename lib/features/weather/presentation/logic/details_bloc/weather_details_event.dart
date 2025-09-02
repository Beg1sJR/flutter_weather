part of 'weather_details_bloc.dart';

@immutable
sealed class WeatherDetailsEvent extends Equatable {}

class LoadWeatherDetails extends WeatherDetailsEvent {
  final String cityName;

  LoadWeatherDetails(this.cityName);

  @override
  List<Object?> get props => [cityName];
}
