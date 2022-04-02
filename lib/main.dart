import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/settings/settings_bloc.dart';
import 'package:weather_app/blocs/theme/theme_bloc.dart';
import 'package:weather_app/pages/home_screen.dart';
import 'package:weather_app/services/weather_api_services.dart';

import 'blocs/weather/weather_bloc.dart';
import 'repositories/weather_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepository(
        weatherApiServices: WeatherApiServices(httpClient: http.Client()),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<WeatherBloc>(
            create: (context) => WeatherBloc(
              weatherRepository: context.read<WeatherRepository>(),
            ),
          ),
          BlocProvider<SettingsBloc>(
            create: (context) => SettingsBloc(),
          ),
          BlocProvider<ThemeBloc>(
            create: (context) =>
                ThemeBloc(weatherBloc: context.read<WeatherBloc>()),
          )
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
          return MaterialApp(
            title: 'Weather app',
            debugShowCheckedModeBanner: false,
            theme: state.appTheme == AppTheme.light
                ? ThemeData.light()
                : ThemeData.dark(),
            home: const HomeScreen(),
          );
        }),
      ),
    );
  }
}
