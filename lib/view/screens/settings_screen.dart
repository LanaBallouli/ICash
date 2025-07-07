import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_constants.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import 'package:test_sales/view/widgets/main_widgets/custom_button_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/dialog_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/main_appbar_widget.dart';

import '../../controller/lang_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final langController = Provider.of<LangController>(context, listen: false);
    String currentLangCode = langController.currentLangCode;

    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: MainAppbarWidget(title: local.settings_screen),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(
              height: 24.h,
            ),
            _buildTitleRow(langController, Icons.settings_outlined,
                local.general_settings),
            SizedBox(
              height: 12.h,
            ),
            _buildButton(
              langController: langController,
              icon: Icons.translate,
              title: local.language,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      title: Text(
                        "Select Language",
                        textAlign: TextAlign.center,
                        style: AppStyles.getFontStyle(
                          langController,
                          fontSize: 18.sp,
                        ),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomButtonWidget(
                            title: "Arabic",
                            onPressed: () {
                              langController.changeLang(
                                  langCode: currentLangCode = 'ar');
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(height: 12.h),
                          CustomButtonWidget(
                            title: "English",
                            onPressed: () {
                              langController.changeLang(
                                  langCode: currentLangCode = 'en');
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            SizedBox(
              height: 24.h,
            ),
            _buildTitleRow(
                langController, Icons.person_2_outlined, local.account),
            SizedBox(
              height: 12.h,
            ),
            _buildButton(
              langController: langController,
              icon: Icons.email_outlined,
              title: local.manage_profile,
              onPressed: () {},
            ),
            SizedBox(
              height: 24.h,
            ),
            _buildTitleRow(
                langController, Icons.analytics_outlined, local.sales_settings),
            SizedBox(
              height: 12.h,
            ),
            _buildButton(
              langController: langController,
              icon: Icons.analytics_outlined,
              title: local.daily_sales_target,
              onPressed: () {},
            ),
            SizedBox(
              height: 6.h,
            ),
            _buildButton(
              langController: langController,
              icon: Icons.calendar_month,
              title: local.monthly_sales_target,
              onPressed: () {},
            ),
            Spacer(),
            CustomButtonWidget(title: "Log Out", color: AppConstants.errorColor, ),
            SizedBox(height: 28.h,)
          ],
        ),
      ),
    );
  }

  Widget _buildTitleRow(
      LangController langController, IconData icon, String title) {
    return Row(
      children: [
        Icon(
          icon,
          color: Color(0xFF6C757D),
          size: 20.h,
        ),
        SizedBox(
          width: 8.w,
        ),
        Text(
          title,
          style: AppStyles.getFontStyle(
            langController,
            color: Color(0xFF6C757D),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildButton(
      {required LangController langController,
      required IconData icon,
      required String title,
      required Function()? onPressed}) {
    return Container(
      width: double.infinity,
      height: 60.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
        border: Border.all(
          color: Color(0xFFE9ECEF),
        ),
      ),
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: AppStyles.getFontStyle(
            langController,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_outlined,
          color: Color(0xFF6C757D),
          size: 20.r,
        ),
        onTap: onPressed,
      ),
    );
  }
}
