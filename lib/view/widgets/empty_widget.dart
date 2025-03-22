import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/controller/lang_controller.dart';

class EmptyWidget extends StatelessWidget {
  String title;

  EmptyWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    LangController langController =
        Provider.of<LangController>(context, listen: false);
    return Center(
      child: SizedBox(
        width: 200,
        child: Text(
          textAlign: TextAlign.center,
          title,
          style: AppStyles.getFontStyle(
            langController,
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
