import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomEmptyWidget extends StatelessWidget {
  const CustomEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.find_in_page,
            size: 45,
          ),
          const SizedBox(height: 10),
          Text(AppLocalizations.of(context)!.noData)
        ],
      ),
    );
  }
}
