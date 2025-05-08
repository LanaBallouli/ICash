import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/controller/lang_controller.dart';
import '../../../../controller/management_controller.dart';
import '../../../../l10n/app_localizations.dart';
import '../../main_widgets/input_widget.dart';

class NameInputWidget extends StatelessWidget {
  String? hintText;
  String title;
  TextEditingController nameController;

  NameInputWidget({super.key, required this.hintText, required this.nameController, required this.title});

  @override
  Widget build(BuildContext context) {
    final langController = Provider.of<LangController>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Consumer<ManagementController>(
        builder: (context, managementController, _) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppStyles.getFontStyle(
                  langController,
                  color: Color(0xFF6C7278),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              InputWidget(
                textEditingController: nameController,
                obscureText: false,
                keyboardType: TextInputType.name,
                labelColor: Colors.grey,
                hintText: hintText,
                onChanged: (value) => managementController.validateField(
                  field: 'name',
                  value: value,
                  context: context,
                ),
                errorText: managementController.errors['name'],
              ),
            ],
          );
        },
      ),
    );
  }
}