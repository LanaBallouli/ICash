import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/controller/lang_controller.dart';
import 'package:test_sales/controller/management_controller.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import 'package:test_sales/model/region.dart';
import 'package:test_sales/model/users.dart';
import 'package:test_sales/view/widgets/main_widgets/dialog_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/main_appbar_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/salesman_widgets/region_input_widget.dart';
import '../../../../app_constants.dart';
import '../../../widgets/main_widgets/custom_button_widget.dart';
import '../../../widgets/management_widgets/salesman_widgets/management_input_widget.dart';
import '../../../widgets/management_widgets/salesman_widgets/type_input_widget.dart';

class AddSalesmanScreen extends StatelessWidget {
  const AddSalesmanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final langController = Provider.of<LangController>(context, listen: false);
    ManagementController managementController =
        Provider.of<ManagementController>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppbarWidget(
        title: AppLocalizations.of(context)!.add_salesman,
        leading: Consumer<ManagementController>(
          builder: (context, managementController, child) {
            return IconButton(
              onPressed: () {
                Navigator.pop(context);
                managementController.clearFields();
                managementController.clearErrors();
              },
              icon: Icon(Icons.arrow_back),
            );
          },
        ),
      ),
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
              ManagementInputWidget(
                hintText: AppLocalizations.of(context)!.enter_salesman_name,
                controller: managementController.nameController,
                title: AppLocalizations.of(context)!.full_name,
                keyboardType: TextInputType.text,
                onChanged: (value) => managementController.validateField(
                    context: context, field: 'name', value: value),
                errorText: managementController.errors['name'],
              ),
              ManagementInputWidget(
                hintText: "demo@demo.com",
                controller: managementController.emailController,
                title: AppLocalizations.of(context)!.email,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => managementController.validateField(
                    context: context, field: 'email', value: value),
                errorText: managementController.errors['email'],
              ),
              ManagementInputWidget(
                hintText: AppLocalizations.of(context)!.enter_salesman_password,
                controller: managementController.passwordController,
                title: AppLocalizations.of(context)!.password,
                keyboardType: TextInputType.text,
                onChanged: (value) => managementController.validateField(
                    context: context, field: 'password', value: value),
                errorText: managementController.errors['password'],
                obscureText: managementController.obscureText,
                suffixIcon: IconButton(
                  onPressed: () =>
                      managementController.togglePasswordVisibility(),
                  icon: managementController.obscureText
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                ),
              ),
              ManagementInputWidget(
                hintText: AppLocalizations.of(context)!.enter_salesman_phone,
                controller: managementController.phoneNumberController,
                title: AppLocalizations.of(context)!.phone,
                keyboardType: TextInputType.phone,
                onChanged: (value) => managementController.validateField(
                    context: context, field: 'phone', value: value),
                errorText: managementController.errors['phone'],
              ),
              RegionInputWidget(
                typeOptions: [
                  'Amman',
                  "Zarqaa",
                ],
                selectedRegion: managementController.selectedRegion,
                onChange: (value) =>
                    managementController.setSelectedRegion(value, context),
                err: managementController.errors['region'],
                hintText: AppLocalizations.of(context)!.choose_region,
              ),
              TypeInputWidget(
                hintText: AppLocalizations.of(context)!.choose_salesman_type,
                selectedType: managementController.selectedType,
                typeOptions: ["Cash", "Debt"],
              ),
              ManagementInputWidget(
                hintText: AppLocalizations.of(context)!.select_target_prompt,
                controller: managementController.targetController,
                title: AppLocalizations.of(context)!.select_target,
                keyboardType: TextInputType.number,
                onChanged: (value) => managementController.validateField(
                    context: context, field: 'target', value: value),
                errorText: managementController.errors['target'],
              ),
              ManagementInputWidget(
                hintText: AppLocalizations.of(context)!.add_notes,
                controller: managementController.notesController,
                title: AppLocalizations.of(context)!.notes,
                keyboardType: TextInputType.text,
                onChanged: (value) {},
                errorText: null,
                maxLines: 3,
                height: 100.h,
              ),
              SizedBox(height: 20.h),
              _buildButtonsRow(context),
              SizedBox(height: 20.h),
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
        Expanded(
          child: Consumer<ManagementController>(
            builder: (context, managementController, child) {
              return CustomButtonWidget(
                title: AppLocalizations.of(context)!.save,
                colors: [
                  AppConstants.primaryColor2,
                  AppConstants.primaryColor2
                ],
                borderRadius: 12.r,
                titleColor: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                onPressed: () {
                  print("Debug: Validating form with the following inputs:");
                  print("Email: ${managementController.emailController.text}");
                  print(
                      "Password: ${managementController.passwordController.text}");
                  print("Name: ${managementController.nameController.text}");
                  print(
                      "Phone: ${managementController.phoneNumberController.text}");
                  print(
                      "Target: ${managementController.targetController.text}");
                  print("Type: ${managementController.selectedType}");
                  print("Region: ${managementController.selectedRegion}");

                  managementController.validateForm(
                    context: context,
                    email: managementController.emailController.text,
                    password: managementController.passwordController.text,
                    name: managementController.nameController.text,
                    phone: managementController.phoneNumberController.text,
                    target: managementController.targetController.text,
                    type: managementController.selectedType,
                    region: managementController.selectedRegion,
                  );

                  print(
                      "Debug: Is form valid? ${managementController.isFormValid()}");

                  if (managementController.isFormValid()) {
                    final phone = int.tryParse(
                        managementController.phoneNumberController.text);
                    final target = double.tryParse(
                        managementController.targetController.text);

                    print("Debug: Parsed phone number: $phone");
                    print("Debug: Parsed target achievement: $target");

                    managementController.addNewUser(
                      Users(
                          fullName: managementController.nameController.text,
                          email: managementController.emailController.text,
                          password:
                              managementController.passwordController.text,
                          phone: phone,
                          region: Region(
                              name: managementController.selectedRegion, id: 1),
                          targetAchievement: target,
                          closedDeals: 0,
                          totalSales: 0,
                          notes: managementController.notesController.text,
                          createdAt: DateTime.now(),
                          type: managementController.selectedType,
                          role: "Sales Man"),
                    );

                    print("Debug: New user added successfully.");

                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return DialogWidget(
                          title:
                              AppLocalizations.of(context)!.salesman_creation,
                          imageUrl: "assets/images/success.png",
                          actions: [
                            CustomButtonWidget(
                              title: AppLocalizations.of(context)!.ok,
                              onPressed: () {
                                Navigator.pop(context);
                                managementController.clearFields();
                                managementController.clearErrors();
                              },
                              borderRadius: 12.r,
                              colors: [
                                AppConstants.primaryColor2,
                                AppConstants.primaryColor2
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    print("Debug: Form validation failed.");

                    showDialog(
                      context: context,
                      builder: (context) {
                        return DialogWidget(
                          title: AppLocalizations.of(context)!
                              .something_went_wrong,
                          content:
                              AppLocalizations.of(context)!.fill_all_fields,
                          imageUrl: "assets/images/cancel.png",
                          actions: [
                            CustomButtonWidget(
                              title: AppLocalizations.of(context)!.ok,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              borderRadius: 12.r,
                              colors: [
                                AppConstants.primaryColor2,
                                AppConstants.primaryColor2
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              );
            },
          ),
        ),
        SizedBox(width: 20.h),
        Expanded(child: Consumer<ManagementController>(
          builder: (context, managementController, child) {
            return CustomButtonWidget(
              title: AppLocalizations.of(context)!.cancel,
              colors: [AppConstants.buttonColor, AppConstants.buttonColor],
              borderRadius: 12.r,
              titleColor: Colors.grey,
              fontSize: 15.sp,
              onPressed: () {
                Navigator.pop(context);
                managementController.clearFields();
                managementController.clearErrors();
              },
            );
          },
        ))
      ],
    );
  }
}
