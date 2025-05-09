import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/controller/lang_controller.dart';
import '../../../app_constants.dart';

class CustomButtonWidget extends StatelessWidget {
  String? title;
  VoidCallback? onPressed;
  List<Color>? colors;
  Color? titleColor;
  double? borderRadius;
  TextStyle? style;
  double? height;
  double? width;
  double? fontSize;
  FontWeight? fontWeight;

  CustomButtonWidget(
      {super.key,
      required this.title,
      this.style,
      this.onPressed,
      this.colors,
      this.titleColor,
      this.borderRadius,
      this.width,
      this.height,
      this.fontSize,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    final langController = Provider.of<LangController>(context, listen: false);
    return Container(
      height: height ?? 48.h,
      width: width ?? 307.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 69),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors ?? [AppConstants.primaryColor2, Color(0xFF0F481F)],
        ),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          title!,
          style: style ??
              AppStyles.getFontStyle(
                langController,
                fontSize: fontSize ?? 14.sp,
                color: titleColor ?? Colors.white,
                fontWeight: fontWeight ?? FontWeight.w600,
              ),
        ),
      ),
    );
  }
}
