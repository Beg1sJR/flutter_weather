import 'dart:developer';

import 'package:app/features/weather/data/data_source/forecast/forecast.dart';
import 'package:app/features/weather/data/data_source/weather/weather.dart';
import 'package:app/features/weather/data/models/weather_entity/weather_entity.dart';
import 'package:app/features/weather/data/repository/favorites/favorites.dart';
import 'package:app/features/weather/data/repository/forecast/forecast.dart';
import 'package:app/features/weather/data/repository/weather/weather.dart';
import 'package:app/features/weather/domain/repository/favorites/favorites.dart';
import 'package:app/features/weather/domain/repository/forecast/forecast.dart';
import 'package:app/features/weather/domain/repository/weather/weather.dart';
import 'package:app/features/weather/presentation/logic/favorites_bloc/favorites_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_settings.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  final talker = TalkerFlutter.init();
  final dio = Dio();

  talker.verbose('Talker launched');
  getIt.registerSingleton<Talker>(talker);
  getIt.registerSingleton<Dio>(dio);

  Bloc.observer = TalkerBlocObserver(
    talker: getIt<Talker>(),
    settings: const TalkerBlocLoggerSettings(
      printEventFullData: false,
      printStateFullData: true,
      printCreations: false,
      printClosings: false,
      printTransitions: false,
      printChanges: true,
    ),
  );
  log('bloc talker launched');

  dio.interceptors.add(
    TalkerDioLogger(
      talker: getIt<Talker>(),
      settings: const TalkerDioLoggerSettings(
        printRequestData: true,
        printRequestHeaders: true,
        printResponseData: true,
        printResponseHeaders: true,
      ),
    ),
  );

  log('dio talker launched');

  // Data source
  getIt.registerLazySingleton<WeatherData>(
    () => WeatherData(dio: getIt<Dio>()),
  );
  log('weather data registered');

  getIt.registerLazySingleton<ForecastData>(
    () => ForecastData(dio: getIt<Dio>()),
  );
  log('forecast data registered');

  // Weather repo
  getIt.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(weatherData: getIt<WeatherData>()),
  );
  log('weather repo registered');

  //Forecast repo
  getIt.registerLazySingleton<ForecastRepository>(
    () => ForecastRepositoryImpl(forecastData: getIt<ForecastData>()),
  );
  log('forecast repo registered');

  // Hive favorites
  final favoritesBox = await Hive.openBox<WeatherEntity>('favorites');

  getIt.registerSingleton<Box<WeatherEntity>>(favoritesBox);
  log('hive favorites box registered');

  // Favorites repo
  getIt.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(getIt<Box<WeatherEntity>>()),
  );

  log('favorites repo registered');

  //blocs
  getIt.registerLazySingleton<FavoritesBloc>(
    () => FavoritesBloc(getIt<FavoritesRepository>()),
  );
  log('favorites bloc registered');
}
