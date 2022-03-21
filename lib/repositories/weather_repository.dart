import 'package:weather_app/exceptions/weather_exception.dart';
import 'package:weather_app/models/custom_error.dart';
import 'package:weather_app/services/weather_api_services.dart';

import '../models/weather.dart';

class WeatherRepository {
  final WeatherApiServices weatherApiServices;
  WeatherRepository({
    required this.weatherApiServices,
  });

  Future<Weather> fetchWeather(String city) async {
    try {
      final int woeid = await weatherApiServices.getWoeid(city);
      print(woeid);
      final Weather weather = await weatherApiServices.getWeather(woeid);
      print(weather);
      return weather;
    } on WeatherException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }
}
