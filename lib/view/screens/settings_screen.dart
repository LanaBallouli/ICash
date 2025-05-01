import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/lang_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
      alignment: Alignment.topLeft,
      child: Consumer<LangController>(
        builder: (context, langController, child) {
          String currentLangCode = langController.currentLangCode;
          return IconButton(
            onPressed: () {
              langController.changeLang(
                  langCode: currentLangCode == 'ar' ? 'en' : 'ar');
            },
            icon: Icon(Icons.language),
          );
        },
      ),
    ),
    );
  }
}
