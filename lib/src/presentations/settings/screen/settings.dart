import 'package:compras_app/src/core/cubits/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, state) {
            return SwitchListTile(
              value: state == ThemeMode.dark,
              title: Text(
                AppLocalizations.of(context)!.darkMode,
                style: GoogleFonts.lato(),
              ),
              subtitle: Text(
                AppLocalizations.of(context)!.darkModeDetail,
                style: GoogleFonts.lato(),
              ),
              onChanged: (isPressed) {
                context.read<ThemeCubit>().changeTheme();
              },
            );
          },
        ),
        ListTile(
          title: Text(
            AppLocalizations.of(context)!.developer,
            style: GoogleFonts.lato(),
          ),
          subtitle: Text(
            AppLocalizations.of(context)!.developedBy,
            style: GoogleFonts.lato(),
          ),
        )
      ],
    );
  }
}
