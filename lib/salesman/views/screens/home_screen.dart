import 'package:flutter/material.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import 'package:test_sales/view/widgets/main_widgets/main_appbar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppbarWidget(title: local.main_screen),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
