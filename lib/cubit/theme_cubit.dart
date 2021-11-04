import 'package:bloc/bloc.dart';
import 'package:compras_app/commons/preferences.dart';
import 'package:flutter/material.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit()
      : super(preferences.getBool('use_dark_theme') ?? false
            ? ThemeData.dark()
            : ThemeData.light());

  Future<void> changeTheme() async {
    state.brightness == Brightness.light
        ? await preferences.setBool('use_dark_theme', true)
        : await preferences.setBool('use_dark_theme', false);
    emit(state.brightness == Brightness.light
        ? ThemeData.dark()
        : ThemeData.light());
  }
}
