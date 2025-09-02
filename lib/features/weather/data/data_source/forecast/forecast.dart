import 'package:app/core/constants/base_url/base_url.dart';
import 'package:app/features/weather/data/models/forecast_weather/forecast.dart';
import 'package:dio/dio.dart';

class ForecastData {
  final Dio dio;

  ForecastData({required this.dio});

  Future<ForecastWeatherModel> getForecast(num lat, num lon) async {
    final response = await dio.get(
      '${OneCallConstants.baseUrl}/data/${OneCallConstants.apiVersion}/onecall',
      queryParameters: {
        'lat': lat,
        'lon': lon,
        'appid': OneCallConstants.apiKey,
        'units': 'metric',
        'lang': 'ru',
        'exclude': 'minutely,alerts,current',
      },
    );

    final responseData = response.data;
    ForecastWeatherModel forecastDetails = ForecastWeatherModel.fromMap(
      responseData as Map<String, dynamic>,
    );

    return forecastDetails;
  }
}
