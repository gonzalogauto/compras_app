import 'package:compras_app/commons/preferences.dart';
import 'package:compras_app/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/src/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SwitchListTile(
          value: preferences.getBool('use_dark_theme') ?? false,
          title: Text('Tema oscuro', style: GoogleFonts.lato()),
          subtitle: Text('Cambia el tema del sistema segun tu preferencia.',
              style: GoogleFonts.lato()),
          onChanged: (isPressed) {
            context.read<ThemeCubit>().changeTheme();
            setState(() {
              pressed = isPressed;
            });
          },
        ),
        ListTile(
          title: Text('Creador', style: GoogleFonts.lato()),
          subtitle: Text('Desarrollado por Gonzalo Gauto.',
              style: GoogleFonts.lato()),
        )
      ],
    );
  }
}
