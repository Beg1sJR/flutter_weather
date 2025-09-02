import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class AppConstants {
  static final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  static const String apiVersion = '2.5';

  static final String apiKey = dotenv.env['API_KEY'] ?? '';

  static const String weatherForecast = '/forecast';
}

abstract class OneCallConstants {
  static final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  static const String apiVersion = '3.0';

  static final String apiKey = dotenv.env['API_KEY'] ?? '';
}
