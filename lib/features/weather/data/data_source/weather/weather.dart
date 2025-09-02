import 'package:app/core/constants/base_url/base_url.dart';
import 'package:app/features/weather/data/models/weather/weather_export.dart';
import 'package:dio/dio.dart';

class WeatherData {
  final Dio dio;

  WeatherData({required this.dio});

  Future<WeatherModel> getWeather(String cityName) async {
    final response = await dio.get(
      '${AppConstants.baseUrl}/data/${AppConstants.apiVersion}/weather',
      queryParameters: {
        'q': cityName,
        'appid': AppConstants.apiKey,
        'units': 'metric',
        'lang': 'ru',
      },
    );

    final responseData = response.data;
    WeatherModel weatherDetail = WeatherModel.fromMap(
      responseData as Map<String, dynamic>,
    );

    return weatherDetail;
  }

  Future<List<String>> getCitySuggestions(String query) async {
    if (query.length < 2) return [];

    try {
      final response = await dio.get(
        'http://api.openweathermap.org/geo/1.0/direct',
        queryParameters: {
          'q': query,
          'limit': 15,
          'appid': AppConstants.apiKey,
        },
      );

      final List<dynamic> data = response.data;

      // 1. Фильтруем мусор
      final filtered = data.where((city) {
        final name = city['name'].toString();
        return name.length >= 4; // Только нормальные названия
      }).toList();

      // 2. Сортируем по длине названия (косвенный признак значимости)
      filtered.sort((a, b) {
        final aName = a['name'].toString();
        final bName = b['name'].toString();
        return bName.length.compareTo(aName.length);
      });

      // 3. Берем топ-5
      return filtered
          .take(15)
          .map((city) => '${city['name']}, ${city['country']}')
          .toList();
    } catch (e) {
      print('Search error: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>> getCityCoordinates(String cityName) async {
    final response = await dio.get(
      'http://api.openweathermap.org/geo/1.0/direct',
      queryParameters: {
        'q': cityName,
        'limit': 1,
        'appid': AppConstants.apiKey,
      },
    );

    final List<dynamic> data = response.data;
    if (data.isNotEmpty) {
      return {
        'name': data[0]['name'],
        'lat': data[0]['lat'],
        'lon': data[0]['lon'],
        'country': data[0]['country'],
      };
    }
    throw Exception('Город не найден');
  }
}
