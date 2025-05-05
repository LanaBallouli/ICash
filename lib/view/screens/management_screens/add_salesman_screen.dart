import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/controller/lang_controller.dart';
import 'package:test_sales/controller/management_controller.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import 'package:test_sales/model/region.dart';
import 'package:test_sales/model/users.dart';
import 'package:test_sales/view/widgets/dialog_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/main_appbar_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/add_salesman_widgets/notes_input_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/add_salesman_widgets/email_field_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/add_salesman_widgets/name_input_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/add_salesman_widgets/password_field_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/add_salesman_widgets/phone_input_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/add_salesman_widgets/region_input_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/add_salesman_widgets/target_input_widget.dart';
import '../../../app_constants.dart';
import '../../widgets/custom_button_widget.dart';
import '../../widgets/management_widgets/add_salesman_widgets/type_input_widget.dart';

class AddSalesmanScreen extends StatelessWidget {
  const AddSalesmanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final langController = Provider.of<LangController>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          MainAppbarWidget(title: AppLocalizations.of(context)!.add_salesman),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.add_salesman_prompt,
                  style: AppStyles.getFontStyle(
                    langController,
                    color: Colors.black54,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              NameInputWidget(
                  hintText: AppLocalizations.of(context)!.enter_salesman_name),
              EmailFieldWidget(),
              PasswordFieldWidget(
                  hintText:
                      AppLocalizations.of(context)!.enter_salesman_password),
              PhoneInputWidget(
                  hintText: AppLocalizations.of(context)!.enter_salesman_phone),
              RegionInputWidget(),
              TypeInputWidget(),
              TargetInputWidget(),
              NotesInputWidget(),
              SizedBox(
                height: 20.h,
              ),
              _buildButtonsRow(context),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Consumer<ManagementController>(
          builder: (context, managementController, child) {
            return CustomButtonWidget(
              title: AppLocalizations.of(context)!.save,
              colors: [AppConstants.primaryColor2, AppConstants.primaryColor2],
              borderRadius: 12.r,
              titleColor: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              onPressed: () {
                // Debug: Log the input values before validation
                print("Debug: Validating form with the following inputs:");
                print("Email: ${managementController.emailController.text}");
                print("Password: ${managementController.passwordController.text}");
                print("Name: ${managementController.nameController.text}");
                print("Phone: ${managementController.phoneNumberController.text}");
                print("Target: ${managementController.targetController.text}");
                print("Type: ${managementController.typeController.text}");
                print("Region: ${managementController.regionController.text}");

                // Validate the form
                managementController.validateForm(
                  context: context,
                  email: managementController.emailController.text,
                  password: managementController.passwordController.text,
                  name: managementController.nameController.text,
                  phone: managementController.phoneNumberController.text,
                  target: managementController.targetController.text,
                  type: managementController.typeController.text,
                  region: managementController.regionController.text,
                );

                // Debug: Log whether the form is valid
                print("Debug: Is form valid? ${managementController.isFormValid()}");

                if (managementController.isFormValid()) {
                  // Debug: Log the parsed phone and target values
                  final phone = int.tryParse(managementController.phoneNumberController.text);
                  final target = double.tryParse(managementController.targetController.text);

                  print("Debug: Parsed phone number: $phone");
                  print("Debug: Parsed target achievement: $target");

                  // Add the new user
                  managementController.addNewUser(
                    Users(
                      fullName: managementController.nameController.text,
                      email: managementController.emailController.text,
                      password: managementController.passwordController.text,
                      phone: phone,
                      region: Region(name: managementController.regionController.text, id: 1),
                      targetAchievement: target,
                      closedDeals: 0,
                      totalSales: 0,
                      notes: managementController.notesController.text,
                      createdAt: DateTime.now(),
                    ),
                  );

                  // Debug: Log success message
                  print("Debug: New user added successfully.");

                  // Navigate back and show success dialog
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DialogWidget(
                        title: AppLocalizations.of(context)!.salesman_creation,
                        imageUrl: "assets/images/success.png",
                        actions: [
                          CustomButtonWidget(
                            title: AppLocalizations.of(context)!.ok,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            borderRadius: 12.r,
                            colors: [AppConstants.primaryColor2, AppConstants.primaryColor2],
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  // Debug: Log failure message
                  print("Debug: Form validation failed.");

                  // Show error dialog
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DialogWidget(
                        title: AppLocalizations.of(context)!.something_went_wrong,
                        content: AppLocalizations.of(context)!.fill_all_fields,
                        imageUrl: "assets/images/cancel.png",
                        actions: [
                          CustomButtonWidget(
                            title: AppLocalizations.of(context)!.ok,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            borderRadius: 12.r,
                            colors: [AppConstants.primaryColor2, AppConstants.primaryColor2],
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            );          },
        )),
        SizedBox(
          width: 20.h,
        ),
        Expanded(
          child: CustomButtonWidget(
            title: AppLocalizations.of(context)!.cancel,
            colors: [AppConstants.buttonColor, AppConstants.buttonColor],
            borderRadius: 12.r,
            titleColor: Colors.grey,
            fontSize: 15.sp,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        )
      ],
    );
  }
}
