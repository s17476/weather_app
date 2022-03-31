import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsState.initial());

  void toggleTempUnit() {
    emit(
      state.copyWith(
        tempUnit: state.tempUnit == TempUnit.celsjus
            ? TempUnit.farenheit
            : TempUnit.celsjus,
      ),
    );
  }
}
