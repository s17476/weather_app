import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/constants/consatnts.dart';

import 'package:weather_app/cubits/weather/weather_cubit.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  late final StreamSubscription streamSubscription;
  final WeatherCubit weatherCubit;

  ThemeCubit({
    required this.weatherCubit,
  }) : super(ThemeState.initial()) {
    streamSubscription =
        weatherCubit.stream.listen((WeatherState weatherState) {
      if (weatherState.weather.theTemp > kWarmOrNot) {
        emit(state.copyWith(appTheme: AppTheme.light));
      } else {
        emit(state.copyWith(appTheme: AppTheme.dark));
      }
    });
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
