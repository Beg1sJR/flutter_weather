part of 'forecast_bloc.dart';

@immutable
sealed class ForecastEvent extends Equatable {}

class LoadForecastDetails extends ForecastEvent {
  final num lat;
  final num lon;

  LoadForecastDetails(this.lat, this.lon);

  @override
  List<Object?> get props => [lat, lon];
}
