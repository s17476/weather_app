import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:weather_app/constants/consatnts.dart';
import 'package:weather_app/cubits/settings/settings_cubit.dart';
import 'package:weather_app/pages/search_screen.dart';
import 'package:weather_app/pages/settings_screen.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/services/weather_api_services.dart';
import 'package:weather_app/widgets/error_dialog.dart';

import '../cubits/weather/weather_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _city;

  // @override
  // void initState() {
  //   super.initState();
  //   _fetchWeather();
  // }

  // _fetchWeather() {
  //   context.read<WeatherCubit>().fetchWeather('london');
  // }

  String showTemperature(double temperature) {
    final tempUnit = context.watch<SettingsCubit>().state.tempUnit;

    if (tempUnit == TempUnit.farenheit) {
      return '${((temperature * 9 / 5) + 32).toStringAsFixed(1)} ℉';
    } else {
      return temperature.toStringAsFixed(1) + '℃';
    }
  }

  Widget showIcon(String abbr) {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/images/loading.gif',
      image: 'https://$kHost/static/img/weather/png/64/$abbr.png',
      width: 64,
      height: 64,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather app'),
        actions: [
          IconButton(
            onPressed: () async {
              _city = await Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const SearchScreen();
                },
              ));
              if (_city != null) {
                context.read<WeatherCubit>().fetchWeather(_city!);
              }
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () async {
              _city = await Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const SettingsScreen();
                },
              ));
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: BlocConsumer<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state.status == WeatherStatus.initial) {
            return const Center(
              child: Text(
                'Select a city',
                style: TextStyle(fontSize: 20),
              ),
            );
          }
          if (state.status == WeatherStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status == WeatherStatus.error &&
              state.weather.title == '') {
            return const Center(
              child: Text(
                'Select a city',
                style: TextStyle(fontSize: 20),
              ),
            );
          }
          return ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 6,
              ),
              Text(
                state.weather.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                TimeOfDay.fromDateTime(state.weather.lastUpdated)
                    .format(context),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    showTemperature(state.weather.theTemp),
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    children: [
                      Text(
                        showTemperature(state.weather.maxTemp),
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        showTemperature(state.weather.minTemp),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  showIcon(state.weather.weatherStateAbbr),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    state.weather.weatherStateName,
                    style: const TextStyle(fontSize: 32),
                  )
                ],
              ),
            ],
          );
        },
        listener: (context, state) {
          if (state.status == WeatherStatus.error) {
            errorDialog(context, state.error.errMsg);
          }
        },
      ),
    );
  }
}
