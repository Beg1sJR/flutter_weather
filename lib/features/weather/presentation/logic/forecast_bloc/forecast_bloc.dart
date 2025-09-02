import 'package:app/features/weather/data/models/forecast_weather/forecast.dart';
import 'package:app/features/weather/domain/repository/forecast/forecast.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'forecast_event.dart';
part 'forecast_state.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  final ForecastRepository forecastRepository;
  ForecastBloc(this.forecastRepository) : super(ForecastInitial()) {
    on<LoadForecastDetails>((event, emit) async {
      emit(ForecastLoading());
      try {
        //       final dataSource = di.getIt<WeatherData>();
        // final newSuggestions = await dataSource.getCitySuggestions(query);

        final forecastDetails = await forecastRepository.getForecast(
          event.lat,
          event.lon,
        );
        emit(ForecastLoaded(forecastDetails));
      } catch (e) {
        emit(ForecastError(message: e.toString()));
      }
    });
  }
}
