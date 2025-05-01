import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app_styles.dart';
import '../../../controller/lang_controller.dart';

class TitleWidget extends StatelessWidget {
  final String title;

  const TitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final langController = Provider.of<LangController>(context);
    return Text(
      title,
      style: AppStyles.getFontStyle(
        langController,
        fontWeight: FontWeight.w600,
        color: Colors.black,
        fontSize: 20,
      ),
    );
  }
}
