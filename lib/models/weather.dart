import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String weatherStateName;
  final String weatherStateAbbr;
  final String created;
  final double minTemp;
  final double maxTemp;
  final double theTemp;
  final String title;
  final int woeid;
  final DateTime lastUpdated;

  Weather({
    required this.weatherStateName,
    required this.weatherStateAbbr,
    required this.created,
    required this.minTemp,
    required this.maxTemp,
    required this.theTemp,
    required this.title,
    required this.woeid,
    required this.lastUpdated,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final consolidateWeather = json['consolidated_weather'][0];
    return Weather(
      weatherStateName: consolidateWeather['weather_state_name'],
      weatherStateAbbr: consolidateWeather['weather_state_abbr'],
      created: consolidateWeather['created'],
      minTemp: consolidateWeather['min_temp'],
      maxTemp: consolidateWeather['max_temp'],
      theTemp: consolidateWeather['the_temp'],
      title: json['title'],
      woeid: json['woeid'],
      lastUpdated: DateTime.now(),
    );
  }

  factory Weather.initial() {
    return Weather(
      weatherStateName: '',
      weatherStateAbbr: '',
      created: '',
      minTemp: 100,
      maxTemp: 100,
      theTemp: 100,
      title: '',
      woeid: -1,
      lastUpdated: DateTime(1970),
    );
  }

  @override
  List<Object> get props {
    return [
      weatherStateName,
      weatherStateAbbr,
      created,
      minTemp,
      maxTemp,
      theTemp,
      title,
      woeid,
      lastUpdated,
    ];
  }

  @override
  String toString() {
    return 'Weather(weatherStateName: $weatherStateName, weatherStateAbbr: $weatherStateAbbr, created: $created, minTemp: $minTemp, maxTemp: $maxTemp, theTemp: $theTemp, title: $title, woeid: $woeid, lastUpdated: $lastUpdated)';
  }
}
