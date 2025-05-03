import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/controller/lang_controller.dart';

import '../../../controller/login_controller.dart';
import '../../../l10n/app_localizations.dart';
import '../main_widgets/input_widget.dart';

class NameInputWidget extends StatelessWidget {
  String? hintText;

  NameInputWidget({super.key, this.hintText});

  @override
  Widget build(BuildContext context) {
    final loginController = context.watch<LoginController>();
    final langController = Provider.of<LangController>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Selector<LoginController, String?>(
        selector: (context, loginController) => loginController.errors['name'],
        builder: (context, errorText, _) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.full_name,
                style: AppStyles.getFontStyle(
                  langController,
                  color: Color(0xFF6C7278),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              InputWidget(
                textEditingController: loginController.nameController,
                obscureText: false,
                keyboardType: TextInputType.name,
                prefixIcon: const Icon(Icons.person),
                labelColor: Colors.grey,
                hintText: hintText ??
                    AppLocalizations.of(context)!.enter_name,
                onChanged: (value) => loginController.validateField(
                  field: 'name',
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
