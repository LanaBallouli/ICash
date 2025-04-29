import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/controller/lang_controller.dart';

class ButtonWidget extends StatelessWidget {
  String buttonName;
  Color buttonColor;
  Color textColor;
  Function() onPressed;

  ButtonWidget(
      {required this.buttonName,
        required this.buttonColor,
        required this.textColor,
        required this.onPressed});

  @override
  Widget build(BuildContext context) {
    LangController langController =
    Provider.of<LangController>(context, listen: false);
    TextStyle style = AppStyles.getFontStyle(
      langController,
      color: textColor,
      fontSize: 16.sp,
      fontWeight: FontWeight.normal,
    );

    return Container(
      height: 56,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: buttonColor,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          buttonName,
          style: style,
        ),
      ),
    );
  }
}
