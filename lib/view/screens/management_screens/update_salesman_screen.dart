import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_constants.dart';
import 'package:test_sales/controller/management_controller.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import 'package:test_sales/model/users.dart';
import 'package:test_sales/view/widgets/custom_button_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/main_appbar_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/add_salesman_widgets/email_field_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/add_salesman_widgets/name_input_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/add_salesman_widgets/notes_input_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/add_salesman_widgets/password_field_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/add_salesman_widgets/phone_input_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/add_salesman_widgets/region_input_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/add_salesman_widgets/target_input_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/add_salesman_widgets/type_input_widget.dart';
import 'package:test_sales/view/widgets/dialog_widget.dart';

import '../../../model/region.dart';

class UpdateSalesmanScreen extends StatelessWidget {
  final Users user;
  final int index;

  const UpdateSalesmanScreen({
    super.key,
    required this.user,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final managementController = context.watch<ManagementController>();

    if (managementController.nameController.text.isEmpty) {
      managementController.nameController.text = user.fullName ?? "";
    }
    if (managementController.emailController.text.isEmpty) {
      managementController.emailController.text = user.email ?? "";
    }
    if (managementController.phoneNumberController.text.isEmpty) {
      managementController.phoneNumberController.text = user.phone.toString();
    }
    if (managementController.targetController.text.isEmpty) {
      managementController.targetController.text =
          user.targetAchievement?.toString() ?? "";
    }
    if (managementController.typeController.text.isEmpty && user.type != null) {
      managementController.typeController.text = user.type!;
    }

    if (managementController.selectedRegion == null && user.region != null) {
      managementController.setSelectedRegion(user.region!.name, context);
    }

    if (managementController.selectedType == null && user.type != null) {
      managementController.setSelectedType(user.type, context);
    }

    if (managementController.passwordController.text.isEmpty) {
      managementController.passwordController.text = user.password ?? "";
    }

    if (managementController.notesController.text.isEmpty) {
      managementController.notesController.text = user.notes ?? "";
    }



    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppbarWidget(
        title: "${user.fullName} - ${AppLocalizations.of(context)!.update}",
        leading: Consumer<ManagementController>(
          builder: (context, managementController, child) {
            return IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
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
              NameInputWidget(
                  hintText: AppLocalizations.of(context)!.enter_name),
              EmailFieldWidget(),
              PasswordFieldWidget(
                hintText: AppLocalizations.of(context)!.enter_salesman_password,
              ),
              PhoneInputWidget(),
              RegionInputWidget(),
              TargetInputWidget(),
              TypeInputWidget(),
              SizedBox(height: 15.h,),
              NotesInputWidget(),
              SizedBox(height: 15.h,),
              _buildButtonsRow(context, managementController),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonsRow(
      BuildContext context, ManagementController managementController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomButtonWidget(
            title: AppLocalizations.of(context)!.save,
            colors: [AppConstants.primaryColor2, AppConstants.primaryColor2],
            borderRadius: 12.r,
            titleColor: Colors.white,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            onPressed: () {
              // Validate form
              managementController.validateForm(
                context: context,
                name: managementController.nameController.text,
                email: managementController.emailController.text,
                password: managementController.passwordController.text,
                phone: managementController.phoneNumberController.text,
                target: managementController.targetController.text,
                type: managementController.typeController.text,
                region: managementController.selectedRegion,
              );

              if (!managementController.isFormValid()) {
                // Show error dialog if form is invalid
                showDialog(
                  context: context,
                  builder: (context) => DialogWidget(
                    title: AppLocalizations.of(context)!.something_went_wrong,
                    content: AppLocalizations.of(context)!.fill_all_fields,
                    imageUrl: "assets/images/cancel.png",
                    actions: [
                      CustomButtonWidget(
                        title: AppLocalizations.of(context)!.ok,
                        onPressed: Navigator.of(context).pop,
                        borderRadius: 12.r,
                        colors: [
                          AppConstants.primaryColor2,
                          AppConstants.primaryColor2
                        ],
                      )
                    ],
                  ),
                );
                return;
              }

              final phone =
                  int.tryParse(managementController.phoneNumberController.text);
              final target =
                  double.tryParse(managementController.targetController.text);

              if (phone == null || target == null) {
                showDialog(
                  context: context,
                  builder: (context) => DialogWidget(
                    title: AppLocalizations.of(context)!.something_went_wrong,
                    content: AppLocalizations.of(context)!.fill_all_fields,
                    imageUrl: "assets/images/cancel.png",
                    actions: [
                      CustomButtonWidget(
                        title: AppLocalizations.of(context)!.ok,
                        onPressed: Navigator.of(context).pop,
                        borderRadius: 12.r,
                        colors: [
                          AppConstants.primaryColor2,
                          AppConstants.primaryColor2
                        ],
                      )
                    ],
                  ),
                );
                return;
              }

              // Create updated user object
              final updatedUser = Users(
                id: user.id,
                fullName: managementController.nameController.text,
                email: managementController.emailController.text,
                password: managementController.passwordController.text,
                phone: phone,
                region: Region(name: managementController.selectedRegion!),
                targetAchievement: target,
                type: managementController.typeController.text,
                notes: managementController.notesController.text,
                closedDeals: user.closedDeals,
                totalSales: user.totalSales,
                createdAt: user.createdAt,
                updatedAt: DateTime.now(),
              );

              managementController.updateUser(user: updatedUser, index: index);

              showDialog(
                context: context,
                builder: (context) => DialogWidget(
                  title: AppLocalizations.of(context)!.salesman_updated,
                  imageUrl: "assets/images/success.png",
                  actions: [
                    CustomButtonWidget(
                      title: AppLocalizations.of(context)!.ok,
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        managementController.clearFields();
                        managementController.clearErrors();
                      },
                      borderRadius: 12.r,
                      colors: [
                        AppConstants.primaryColor2,
                        AppConstants.primaryColor2
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(width: 20.h),
        Expanded(
          child: CustomButtonWidget(
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
          ),
        ),
      ],
    );
  }
}
