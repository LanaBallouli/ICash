import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../app_styles.dart';
import '../../../controller/lang_controller.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final String date;
  final Color? cardColor;
  final Color textColor;
  final LangController langController;
  final Widget widget;

  const CardWidget({
    super.key,
    required this.title,
    this.cardColor,
    this.textColor = Colors.black,
    required this.date,
    required this.langController,
    required this.widget,
  });


  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      elevation: 4,
      color: cardColor ?? const Color(0xFFEBF1FD),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                date,
                style: GoogleFonts.cabin(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: AppStyles.getFontStyle(
                  langController,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 8),
              widget,
            ],
          ),
        ),
      ),
    );
  }
}
