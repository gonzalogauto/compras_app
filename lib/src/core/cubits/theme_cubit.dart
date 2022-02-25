import 'package:bloc/bloc.dart';
import 'package:compras_app/src/core/locator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit()
      : super(
          locator.get<SharedPreferences>().getBool('use_dark_theme') ?? false
              ? ThemeMode.dark
              : ThemeMode.light,
        );

  Future<void> changeTheme() async {
    state == ThemeMode.light
        ? await locator.get<SharedPreferences>().setBool('use_dark_theme', true)
        : await locator
            .get<SharedPreferences>()
            .setBool('use_dark_theme', false);
    emit(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }
}
