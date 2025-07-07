import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/controller/lang_controller.dart';
import 'package:test_sales/controller/management_controller.dart';
import 'package:test_sales/controller/salesman_controller.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import 'package:test_sales/model/salesman.dart';
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
                selectedRegion: managementController.selectedRegion,
                hintText: AppLocalizations.of(context)!.choose_region,
                regions: AppConstants.getRegions(context),
                onChange: (value) =>
                    managementController.setSelectedRegion(value, context),
                err: managementController.errors['region'],
              ),
              TypeInputWidget(
                hintText: AppLocalizations.of(context)!.choose_salesman_type,
                selectedType: managementController.selectedType,
                typeOptions: AppConstants.getTypes(context),
              ),
              ManagementInputWidget(
                hintText: AppLocalizations.of(context)!.select_target_prompt,
                controller: managementController.monthlyTargetController,
                title: AppLocalizations.of(context)!.monthly_select_target,
                keyboardType: TextInputType.number,
                onChanged: (value) => managementController.validateField(
                    context: context, field: 'target', value: value),
                errorText: managementController.errors['target'],
              ),
              ManagementInputWidget(
                hintText: AppLocalizations.of(context)!.select_target_prompt,
                controller: managementController.dailyTargetController,
                title: AppLocalizations.of(context)!.daily_select_target,
                keyboardType: TextInputType.number,
                onChanged: (value) => managementController.validateField(
                    context: context, field: 'daily_target', value: value),
                errorText: managementController.errors['daily_target'],
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
          child: Consumer2<ManagementController, SalesmanController>(
            builder:
                (context, managementController, salesmanController, child) {
              return CustomButtonWidget(
                title: AppLocalizations.of(context)!.save,
                color:  AppConstants.primaryColor2,
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
                      "Target: ${managementController.monthlyTargetController.text}");
                  print(
                      "daily Target: ${managementController.dailyTargetController.text}");
                  print("Type: ${managementController.selectedType}");
                  print("Region: ${managementController.selectedRegion?.id}");

                  managementController.validateForm(
                    context: context,
                    email: managementController.emailController.text,
                    password: managementController.passwordController.text,
                    name: managementController.nameController.text,
                    phone: managementController.phoneNumberController.text,
                    monthlyTarget:
                        managementController.monthlyTargetController.text,
                    dailyTarget:
                        managementController.dailyTargetController.text,
                    type: managementController.selectedType,
                    region: managementController.selectedRegion,
                  );

                  print(
                      "Debug: Is form valid? ${managementController.isFormValid()}");

                  if (managementController.isFormValid()) {
                    final target = double.tryParse(
                        managementController.monthlyTargetController.text);
                    final dailyTarget = double.tryParse(
                        managementController.dailyTargetController.text);

                    final currentUser = Supabase.instance.client.auth.currentUser;

                    salesmanController.addNewSalesman(SalesMan(
                      fullName: managementController.nameController.text,
                      email: managementController.emailController.text,
                      phone: managementController.phoneNumberController.text,
                      password: managementController.passwordController.text,
                      role: "Salesman",
                      status: "Active",
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                      imageUrl: "assets/images/default_image.png",
                      totalSales: 0.0,
                      closedDeals: 0,
                      monthlyTarget: target!,
                      dailyTarget: dailyTarget!,
                      regionId: managementController.selectedRegion?.id ?? 1,
                      notes: managementController.notesController.text,
                      type: managementController.selectedType!,
                      // supabaseUid: currentUser?.id ?? "",
                    ));

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
                              color: AppConstants.primaryColor2
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
                              color:  AppConstants.primaryColor2
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
              color: AppConstants.primaryColor2,
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
