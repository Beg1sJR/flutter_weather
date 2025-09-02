import 'package:app/features/weather/data/models/weather/weather_export.dart';
import 'package:app/features/weather/domain/repository/weather/weather.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'weather_details_event.dart';
part 'weather_details_state.dart';

class WeatherDetailsBloc
    extends Bloc<WeatherDetailsEvent, WeatherDetailsState> {
  final WeatherRepository weatherRepository;
  WeatherDetailsBloc(this.weatherRepository) : super(WeatherDetailsInitial()) {
    on<LoadWeatherDetails>((event, emit) async {
      emit(WeatherDetailsLoading());
      try {
        final weatherDetails = await weatherRepository.getWeather(
          event.cityName,
        );
        emit(WeatherDetailsLoaded(weatherDetails));
      } catch (e) {
        emit(WeatherDetailsError(e.toString()));
      }
    });
  }
}
