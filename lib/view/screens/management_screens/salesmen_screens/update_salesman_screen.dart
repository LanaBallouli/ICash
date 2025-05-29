import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_constants.dart';
import 'package:test_sales/controller/management_controller.dart';
import 'package:test_sales/controller/salesman_controller.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import 'package:test_sales/view/widgets/main_widgets/custom_button_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/main_appbar_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/salesman_widgets/management_input_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/salesman_widgets/region_input_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/salesman_widgets/type_input_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/dialog_widget.dart';

import '../../../../model/region.dart';
import '../../../../model/salesman.dart';

class UpdateSalesmanScreen extends StatefulWidget {
  final SalesMan salesman;
  final int index;

  const UpdateSalesmanScreen({
    super.key,
    required this.salesman,
    required this.index,
  });

  @override
  State<UpdateSalesmanScreen> createState() => _UpdateSalesmanScreenState();
}

class _UpdateSalesmanScreenState extends State<UpdateSalesmanScreen> {
  late ManagementController managementController;

  @override
  void initState() {
    super.initState();
    managementController =
        Provider.of<ManagementController>(context, listen: false);

    managementController.nameController.text = widget.salesman.fullName ?? "";
    managementController.emailController.text = widget.salesman.email ?? "";
    managementController.phoneNumberController.text =
        widget.salesman.phone.toString();
    managementController.monthlyTargetController.text =
        widget.salesman.monthlyTarget?.toString() ?? "";
    managementController.typeController.text = widget.salesman.type!;
    managementController.setSelectedRegion(
        widget.salesman.region!.name, context);
    managementController.setSelectedType(widget.salesman.type, context);
    managementController.passwordController.text =
        widget.salesman.password ?? "";
    managementController.notesController.text = widget.salesman.notes ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final SalesmanController salesmanController = Provider.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppbarWidget(
        title:
            "${widget.salesman.fullName} - ${AppLocalizations.of(context)!.update}",
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
              ManagementInputWidget(
                hintText: AppLocalizations.of(context)!.enter_name,
                controller: managementController.nameController,
                title: AppLocalizations.of(context)!.salesman_name,
                keyboardType: TextInputType.name,
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
                keyboardType: TextInputType.visiblePassword,
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
                hintText: AppLocalizations.of(context)!.choose_region,
                typeOptions: [
                  "Amman",
                  "Zarqaa",
                ],
                onChange: (value) => managementController.validateField(
                    context: context, field: 'region', value: value),
                err: managementController.errors['region'],
                selectedRegion: managementController.selectedRegion,
              ),
              ManagementInputWidget(
                  hintText: AppLocalizations.of(context)!.select_target_prompt,
                  controller: managementController.monthlyTargetController,
                  title: AppLocalizations.of(context)!.monthly_select_target,
                  keyboardType: TextInputType.number,
                  onChanged: (value) => managementController.validateField(
                      context: context, field: 'target', value: value),
                  errorText: managementController.errors['target']),
              ManagementInputWidget(
                  hintText: AppLocalizations.of(context)!.select_target_prompt,
                  controller: managementController.dailyTargetController,
                  title: AppLocalizations.of(context)!.daily_select_target,
                  keyboardType: TextInputType.number,
                  onChanged: (value) => managementController.validateField(
                      context: context, field: 'daily_target', value: value),
                  errorText: managementController.errors['daily_target']),
              TypeInputWidget(
                hintText: AppLocalizations.of(context)!.choose_salesman_type,
                typeOptions: ["Cash", "Debt"],
                selectedType: managementController.selectedType,
              ),
              SizedBox(
                height: 15.h,
              ),
              ManagementInputWidget(
                  hintText: AppLocalizations.of(context)!.add_notes,
                  controller: managementController.notesController,
                  title: AppLocalizations.of(context)!.notes,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {},
                  errorText: null),
              SizedBox(
                height: 15.h,
              ),
              _buildButtonsRow(
                  context, managementController, salesmanController),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonsRow(
      BuildContext context,
      ManagementController managementController,
      SalesmanController salesmanController) {
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
                monthlyTarget:
                    managementController.monthlyTargetController.text,
                dailyTarget: managementController.dailyTargetController.text,
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

              final target = double.tryParse(
                  managementController.monthlyTargetController.text);
              final dailyTarget = double.tryParse(
                  managementController.dailyTargetController.text);

              if (target == null) {
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
              final updatedUser = SalesMan(
                id: widget.salesman.id,
                fullName: managementController.nameController.text,
                email: managementController.emailController.text,
                password: managementController.passwordController.text,
                phone: managementController.phoneNumberController.text,
                region: Region(name: managementController.selectedRegion!),
                monthlyTarget: target,
                dailyTarget: dailyTarget,
                type: managementController.typeController.text,
                notes: managementController.notesController.text,
                closedDeals: widget.salesman.closedDeals,
                totalSales: widget.salesman.totalSales,
                createdAt: widget.salesman.createdAt,
                updatedAt: DateTime.now(),
              );

              salesmanController.updateUser(
                  user: updatedUser, index: widget.index);

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
