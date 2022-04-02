part of 'settings_bloc.dart';

enum TempUnit {
  celsjus,
  farenheit,
}

class SettingsState extends Equatable {
  final TempUnit tempUnit;

  const SettingsState({
    this.tempUnit = TempUnit.celsjus,
  });

  factory SettingsState.initial() {
    return const SettingsState();
  }

  @override
  List<Object> get props => [tempUnit];

  @override
  String toString() => 'SettingsState(tempUnit: $tempUnit)';

  SettingsState copyWith({
    TempUnit? tempUnit,
  }) {
    return SettingsState(
      tempUnit: tempUnit ?? this.tempUnit,
    );
  }
}
