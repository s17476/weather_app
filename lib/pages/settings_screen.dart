import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/settings/settings_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListTile(
          title: const Text('Temperature unit'),
          subtitle: const Text('Celsjus / Farenheit (Default: Celsjus)'),
          trailing: Switch(
            value: context.watch<SettingsCubit>().state.tempUnit ==
                TempUnit.celsjus,
            onChanged: (_) {
              context.read<SettingsCubit>().toggleTempUnit();
            },
          ),
        ),
      ),
    );
  }
}
