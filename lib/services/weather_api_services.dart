import 'dart:convert';

import 'package:http/http.dart' as http;
import '../constants/consatnts.dart';
import '../exceptions/weather_exception.dart';
import 'http_error_handler.dart';

import '../models/weather.dart';

class WeatherApiServices {
  final http.Client httpClient;
  WeatherApiServices({
    required this.httpClient,
  });

  Future<int> getWoeid(String city) async {
    final Uri uri = Uri(
      scheme: 'http',
      host: kHost,
      path: 'api/location/search/',
      queryParameters: {
        'query': city,
      },
    );

    try {
      final http.Response response = await http.get(uri);

      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }

      final List<dynamic> responseBody = json.decode(response.body);

      if (responseBody.isEmpty) {
        throw WeatherException('Cannot get the woeid of $city');
      }

      if (responseBody.length > 1) {
        throw WeatherException('There are multiple candidates for $city');
      }
      return responseBody[0]['woeid'];
    } catch (e) {
      rethrow;
    }
  }

  Future<Weather> getWeather(int woeid) async {
    final Uri uri = Uri(
      scheme: 'http',
      host: kHost,
      path: '/api/location/$woeid',
    );

    try {
      final http.Response response = await http.get(uri);

      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }

      final Map<String, dynamic> weatherJson = json.decode(response.body);

      final Weather weather = Weather.fromJson(weatherJson);
      print(weather);

      return weather;
    } catch (e) {
      rethrow;
    }
  }
}
