import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsState.initial()) {
    on<ToggleTempUnitEvent>(_toggleUnit);
  }

  FutureOr<void> _toggleUnit(
      ToggleTempUnitEvent event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
          tempUnit: state.tempUnit == TempUnit.celsjus
              ? TempUnit.farenheit
              : TempUnit.celsjus),
    );
  }
}
