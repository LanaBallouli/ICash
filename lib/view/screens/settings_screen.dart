import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_constants.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/controller/management_controller.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import 'package:test_sales/view/screens/registration_screens/login_screen.dart';
import 'package:test_sales/view/widgets/main_widgets/custom_button_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/dialog_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/input_widget.dart';
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
                langController, Icons.analytics_outlined, local.sales_settings),
            SizedBox(
              height: 12.h,
            ),
            _buildButton(
              langController: langController,
              icon: Icons.analytics_outlined,
              title: local.daily_sales_target,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Consumer<ManagementController>(
                      builder: (context, managementController, child) {
                        final dailyTargetCtrl = TextEditingController(
                          text: managementController.dailyTarget.toString(),
                        );
                        return DialogWidget(
                          title: local.set_daily_target,
                          actions: [
                            InputWidget(
                              textEditingController: dailyTargetCtrl,
                              label: local.daily_target,
                              hintText: local.enter_daily_target,
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: 16.h),
                            CustomButtonWidget(
                              title: local.save,
                              onPressed: () {
                                final String value = dailyTargetCtrl.text;
                                final double? parsedValue =
                                    double.tryParse(value);

                                if (parsedValue == null || parsedValue <= 0) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "local.invalid_daily_target",
                                      ),
                                    ),
                                  );
                                  return;
                                }
                                managementController
                                    .setDailyTarget(parsedValue);

                                Navigator.pop(context);
                                print(
                                    "New Daily Target: ${managementController.dailyTarget} --------------------------------");
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
            SizedBox(
              height: 6.h,
            ),
            _buildButton(
              langController: langController,
              icon: Icons.calendar_month,
              title: local.monthly_sales_target,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Consumer<ManagementController>(
                      builder: (context, managementController, child) {
                        final monthlyTargetCtrl = TextEditingController(
                          text: managementController.monthlyTarget.toString(),
                        );
                        return DialogWidget(
                          title: local.set_monthly_target,
                          actions: [
                            InputWidget(
                              textEditingController: monthlyTargetCtrl,
                              label: local.monthly_target,
                              hintText: local.enter_monthly_target,
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: 16.h),
                            CustomButtonWidget(
                              title: local.save,
                              onPressed: () {
                                final String value = monthlyTargetCtrl.text;
                                final double? parsedValue =
                                    double.tryParse(value);

                                if (parsedValue == null || parsedValue <= 0) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "local.invalid_monthly_target",
                                      ),
                                    ),
                                  );
                                  return;
                                }
                                managementController
                                    .setMonthlyTarget(parsedValue);

                                Navigator.pop(context);
                                print(
                                    "New monthly Target: ${managementController.monthlyTarget} --------------------------------");
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
            Spacer(),
            CustomButtonWidget(
              title: local.logout,
              color: AppConstants.errorColor,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return DialogWidget(
                      title: local.logout,
                      content: Text(local.are_you_sure_you_want_to_logout),
                      actions: [
                        CustomButtonWidget(
                          title: local.yes,
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                              (_) => false,
                            );
                          },
                        )
                      ],
                    );
                  },
                );
              },
            ),
            SizedBox(
              height: 28.h,
            )
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
