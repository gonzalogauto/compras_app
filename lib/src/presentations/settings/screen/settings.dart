import '../../../core/cubits/theme_cubit.dart';
import '../../../core/locator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SwitchListTile(
          value: locator.get<SharedPreferences>().getBool('use_dark_theme') ??
              false,
          title: Text(
            'Tema oscuro',
            style: GoogleFonts.lato(),
          ),
          subtitle: Text(
            'Cambia el tema del sistema segun tu preferencia.',
            style: GoogleFonts.lato(),
          ),
          onChanged: (isPressed) {
            context.read<ThemeCubit>().changeTheme();
          },
        ),
        ListTile(
          title: Text(
            'Creador',
            style: GoogleFonts.lato(),
          ),
          subtitle: Text(
            'Desarrollado por Gonzalo Gauto.',
            style: GoogleFonts.lato(),
          ),
        )
      ],
    );
  }
}
