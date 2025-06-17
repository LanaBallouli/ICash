import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app_styles.dart';
import '../../../../controller/lang_controller.dart';
import '../../../l10n/app_localizations.dart';
import 'card_widget.dart';

class DailySalesWidget extends StatelessWidget {
  final String title;
  final String date;
  final Color? cardColor;
  final Color textColor;
  final Color? progressColor;
  final LangController langController;
  final double progress;

  const DailySalesWidget({
    super.key,
    required this.title,
    required this.date,
    this.cardColor = const Color(0xFFEBF1FD),
    this.textColor = Colors.black,
    this.progressColor = Colors.black,
    required this.langController,
    this.progress = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      title: title,
      date: date,
      textColor: textColor,
      cardColor: cardColor,
      langController: langController,
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "${progress.toString()} JD",
              style: AppStyles.getFontStyle(
                langController,
                color: Colors.white,
                fontSize: 18.sp
              ),
            ),
          ),
          SizedBox(height: 30),
          LinearProgressIndicator(
            value: progress / 100,
            backgroundColor: Colors.grey[300],
            color: progress >= 100 ? Colors.green : progressColor,
            borderRadius: BorderRadius.circular(20.r),
          ),
          const SizedBox(height: 8),
          Text(
            '${progress.toStringAsFixed(1)}%',
            style: TextStyle(
              color: progress >= 100 ? Colors.green : progressColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
