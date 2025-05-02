import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/controller/lang_controller.dart';

import '../../app_constants.dart';
import '../../l10n/app_localizations.dart';
import '../../model/users.dart';
import 'custom_button_widget.dart';

class DialogWidget extends StatelessWidget {
  Users user;
  String title;
  String content;
  void Function()? onPressed;

  DialogWidget(
      {super.key,
      required this.user,
      required this.title,
      required this.onPressed,
      required this.content});

  @override
  Widget build(BuildContext context) {
    final langController = Provider.of<LangController>(context, listen: false);
    return AlertDialog(
      backgroundColor: Colors.white,
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
      content: Text(
        content,
        textAlign: TextAlign.center,
        style: AppStyles.getFontStyle(
          langController,
          fontSize: 12,
          color: Colors.black45,
          fontWeight: FontWeight.w400,
        ),
      ),
      actions: [
        CustomButtonWidget(
            title: AppLocalizations.of(context)!.yes,
            colors: [AppConstants.errorColor, AppConstants.errorColor],
            height: 60.h,
            borderRadius: 12.r,
            titleColor: Colors.white,
            width: 300.w,
            onPressed: onPressed),
        SizedBox(
          height: 10.h,
        ),
        CustomButtonWidget(
          title: AppLocalizations.of(context)!.cancel,
          colors: [AppConstants.buttonColor, AppConstants.buttonColor],
          height: 60.h,
          borderRadius: 12.r,
          titleColor: Colors.grey,
          width: 300.w,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
