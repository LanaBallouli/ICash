import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/controller/lang_controller.dart';

import '../../../controller/login_controller.dart';
import '../../../l10n/app_localizations.dart';
import '../main_widgets/input_widget.dart';

class PhoneInputWidget extends StatelessWidget {
  const PhoneInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = context.watch<LoginController>();
    final langController = Provider.of<LangController>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Selector<LoginController, String?>(
        selector: (context, loginController) => loginController.errors['email'],
        builder: (context, errorText, _) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.phone,
                style: AppStyles.getFontStyle(
                  langController,
                  color: Color(0xFF6C7278),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              InputWidget(
                borderColor: Color(0xFFEFF0F6),
                textEditingController: loginController.phoneNumberController,
                obscureText: false,
                keyboardType: TextInputType.phone,
                hintText: AppLocalizations.of(context)!.phone_hint,
                onChanged: (value) => loginController.validateField(
                  field: 'phone',
                  value: value,
                  context: context,
                ),
                errorText: errorText,
              ),
            ],
          );
        },
      ),
    );
  }
}
