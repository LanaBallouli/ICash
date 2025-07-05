import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/controller/lang_controller.dart';

import '../../../app_constants.dart';

class CustomButtonWidget extends StatelessWidget {
  String? title;
  VoidCallback? onPressed;
  Color? color;
  Color? fontColor;
  Color? titleColor;
  double? borderRadius;
  TextStyle? style;
  double? height;
  double? width;
  double? fontSize;
  FontWeight? fontWeight;
  IconData? icon;

  CustomButtonWidget(
      {super.key,
      required this.title,
      this.style,
      this.onPressed,
      this.color,
      this.titleColor,
      this.borderRadius,
      this.width,
      this.height,
      this.fontSize,
      this.fontWeight,
      this.icon,
      this.fontColor});

  @override
  Widget build(BuildContext context) {
    final langController = Provider.of<LangController>(context, listen: false);
    return Container(
      height: height ?? 56.h,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
          color: color ?? AppConstants.primaryColor2,
          border: Border.all(color: Color(0xFFe2e2e2))),
      child: TextButton(
          onPressed: onPressed ?? () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: titleColor ?? Colors.white,
                ),
                SizedBox(
                  width: 10.w,
                ),
              ],
              Text(
                title!,
                style: style ??
                    AppStyles.getFontStyle(
                      langController,
                      fontSize: fontSize ?? 16.sp,
                      color: titleColor ?? Colors.white,
                      fontWeight: fontWeight ?? FontWeight.w600,
                    ),
              ),
            ],
          )),
    );
  }
}
