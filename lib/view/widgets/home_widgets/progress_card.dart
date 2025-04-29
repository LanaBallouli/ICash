import 'package:flutter/material.dart';
import '../../../../app_styles.dart';
import '../../../../controller/lang_controller.dart';
import '../../../l10n/app_localizations.dart';
import 'card_widget.dart';

class ProgressCard extends StatelessWidget {
  final String title;
  final String date;
  final Color? cardColor;
  final Color textColor;
  final Color? progressColor;
  final VoidCallback? onTap;
  final LangController langController;
  final IconData icon;

  const ProgressCard(
      {super.key,
      required this.title,
      required this.date,
      this.cardColor = const Color(0xFFEBF1FD),
      this.textColor = Colors.black,
      this.progressColor = Colors.black,
      this.onTap,
      required this.langController,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    double progress = 0.0;
    return CardWidget(
      title: title,
      date: date,
      textColor: textColor,
      cardColor: cardColor,
      onTap: onTap,
      icon: icon,
      langController: langController,
      widget: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              AppLocalizations.of(context)!.progress,
              style: AppStyles.getFontStyle(
                langController,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(height: 10),
          LinearProgressIndicator(
            value: progress / 100,
            backgroundColor: Colors.grey[300],
            color: progress >= 100 ? progressColor : Colors.green,
            borderRadius: BorderRadius.circular(20),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '${progress.toStringAsFixed(1)}%',
              style: TextStyle(
                color: progress >= 100 ? Colors.green : progressColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
