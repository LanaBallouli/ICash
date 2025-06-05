import 'dart:ui';

import 'package:flutter/cupertino.dart';

import 'l10n/app_localizations.dart';
import 'model/region.dart';

class AppConstants {
  static const Color secondaryColor = Color(0xFF455A64);
  static const Color primaryColor = Color(0xFF170F4C);
  static const Color primaryColor2 = Color(0xFF10376A);
  static const Color buttonColor = Color(0xFFECF0F6);
  static const Color errorColor = Color(0xFF910000);

  static List<Region> getRegions(BuildContext context) {
    return [
      Region(id: 1, name: AppLocalizations.of(context)!.northAmman),
      Region(id: 2, name: AppLocalizations.of(context)!.southAmman),
      Region(id: 3, name: AppLocalizations.of(context)!.eastAmman1),
      Region(id: 4, name: AppLocalizations.of(context)!.eastAmman2),
      Region(id: 5, name: AppLocalizations.of(context)!.westAmman1),
      Region(id: 6, name: AppLocalizations.of(context)!.westAmman2),
      Region(id: 7, name: AppLocalizations.of(context)!.zarqaAndRusseifa),
    ];
  }

  static List<String> getTypes(BuildContext context) {
    return [
      AppLocalizations.of(context)!.cash,
      AppLocalizations.of(context)!.debt,
    ];
  }
}