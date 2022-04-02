import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:weather_app/blocs/weather/weather_bloc.dart';
import 'package:weather_app/constants/consatnts.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final WeatherBloc weatherBloc;
  late final StreamSubscription streamSubscription;

  ThemeBloc({
    required this.weatherBloc,
  }) : super(ThemeState.initial()) {
    streamSubscription = weatherBloc.stream.listen((WeatherState weatherState) {
      if (weatherState.weather.theTemp > kWarmOrNot) {
        add(const ChangeThemeEvent(appTheme: AppTheme.light));
      } else {
        add(const ChangeThemeEvent(appTheme: AppTheme.dark));
      }
    });
    on<ChangeThemeEvent>(
      (event, emit) {
        emit(state.copyWith(appTheme: event.appTheme));
      },
    );
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
