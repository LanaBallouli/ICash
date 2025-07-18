import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/controller/lang_controller.dart';

import '../../../app_constants.dart';
import '../../../l10n/app_localizations.dart';
import 'custom_button_widget.dart';

class DialogWidget extends StatelessWidget {
  String title;
  Widget? content;
  Color? backgroundColor;
  List<Widget>? actions;
  String? imageUrl;
  void Function()? onPressed;

  DialogWidget({
    super.key,
    required this.title,
    this.onPressed,
    this.content,
    this.backgroundColor,
    this.actions,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final langController = Provider.of<LangController>(context, listen: false);
    return SizedBox(
      height: 350,
      width: double.infinity,
      child: AlertDialog(
        backgroundColor: backgroundColor ?? Colors.white,
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: AppStyles.getFontStyle(
            langController,
            fontSize: 14,
            color: Colors.black54,
            fontWeight: FontWeight.w400,
          ),
        ),
        content: SingleChildScrollView(child: content ?? const SizedBox.shrink()),
        actions: actions ??
            [
              CustomButtonWidget(
                  title: AppLocalizations.of(context)!.yes,
                  color: AppConstants.errorColor,
                  height: 60.h,
                  borderRadius: 12.r,
                  titleColor: Colors.white,
                  width: 300.w,
                  onPressed: onPressed ?? () {}),
              SizedBox(
                height: 10.h,
              ),
              CustomButtonWidget(
                title: AppLocalizations.of(context)!.cancel,
                color: AppConstants.buttonColor,
                height: 60.h,
                borderRadius: 12.r,
                titleColor: Colors.grey,
                width: 300.w,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
      ),
    );
  }
}
