import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_constants.dart';
import 'package:test_sales/controller/management_controller.dart';
import 'package:test_sales/controller/salesman_controller.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import 'package:test_sales/view/widgets/main_widgets/custom_button_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/main_appbar_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/dialog_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/salesman_widgets/management_input_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/salesman_widgets/region_input_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/salesman_widgets/type_input_widget.dart';
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

    managementController.nameController.text = widget.salesman.fullName;
    managementController.emailController.text = widget.salesman.email;
    managementController.phoneNumberController.text = widget.salesman.phone;
    managementController.monthlyTargetController.text =
        widget.salesman.monthlyTarget.toString();
    managementController.dailyTargetController.text =
        widget.salesman.dailyTarget.toString();
    managementController.notesController.text = widget.salesman.notes;
    managementController.passwordController.text = widget.salesman.password;

    final allRegions = AppConstants.getRegions(context);
    final selectedRegion = allRegions.firstWhere(
          (r) => r.id == widget.salesman.regionId,
      orElse: () => allRegions.first,
    );

    managementController.setSelectedRegion(selectedRegion, context);
    managementController.setSelectedType(widget.salesman.type, context);
  }

  @override
  Widget build(BuildContext context) {
    final SalesmanController salesmanController = Provider.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppbarWidget(
        title:
            "${widget.salesman.fullName} - ${AppLocalizations.of(context)!.update}",
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
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
                  context: context,
                  field: 'name',
                  value: value,
                ),
                errorText: managementController.errors['name'],
              ),
              ManagementInputWidget(
                hintText: "demo@demo.com",
                controller: managementController.emailController,
                title: AppLocalizations.of(context)!.email,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => managementController.validateField(
                  context: context,
                  field: 'email',
                  value: value,
                ),
                errorText: managementController.errors['email'],
              ),
              ManagementInputWidget(
                hintText: AppLocalizations.of(context)!.enter_salesman_password,
                controller: managementController.passwordController,
                title: AppLocalizations.of(context)!.password,
                keyboardType: TextInputType.visiblePassword,
                onChanged: (value) => managementController.validateField(
                  context: context,
                  field: 'password',
                  value: value,
                ),
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
                  context: context,
                  field: 'phone',
                  value: value,
                ),
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
              ManagementInputWidget(
                hintText: AppLocalizations.of(context)!.select_target_prompt,
                controller: managementController.monthlyTargetController,
                title: AppLocalizations.of(context)!.monthly_select_target,
                keyboardType: TextInputType.number,
                onChanged: (value) => managementController.validateField(
                  context: context,
                  field: 'target',
                  value: value,
                ),
                errorText: managementController.errors['target'],
              ),
              ManagementInputWidget(
                hintText: AppLocalizations.of(context)!.select_target_prompt,
                controller: managementController.dailyTargetController,
                title: AppLocalizations.of(context)!.daily_select_target,
                keyboardType: TextInputType.number,
                onChanged: (value) => managementController.validateField(
                  context: context,
                  field: 'daily_target',
                  value: value,
                ),
                errorText: managementController.errors['daily_target'],
              ),
              TypeInputWidget(
                hintText: AppLocalizations.of(context)!.choose_salesman_type,
                typeOptions: AppConstants.getTypes(context),
                selectedType: managementController.selectedType,
              ),
              SizedBox(height: 15.h),
              ManagementInputWidget(
                hintText: AppLocalizations.of(context)!.add_notes,
                controller: managementController.notesController,
                title: AppLocalizations.of(context)!.notes,
                keyboardType: TextInputType.text,
                onChanged: (value) {},
                errorText: null,
              ),
              SizedBox(height: 15.h),
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
    SalesmanController salesmanController,
  ) {
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
                type: managementController.selectedType,
                region: managementController.selectedRegion,
              );

              if (!managementController.isFormValid()) {
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
                      ),
                    ],
                  ),
                );
                return;
              }

              // Parse numeric fields
              final target = double.tryParse(
                  managementController.monthlyTargetController.text);
              final dailyTarget = double.tryParse(
                  managementController.dailyTargetController.text);

              if (target == null || dailyTarget == null) {
                showDialog(
                  context: context,
                  builder: (context) => DialogWidget(
                    title: AppLocalizations.of(context)!.something_went_wrong,
                    content: AppLocalizations.of(context)!.target_error,
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
                      ),
                    ],
                  ),
                );
                return;
              }

              final updatedUser = SalesMan(
                id: widget.salesman.id,
                fullName: managementController.nameController.text,
                email: managementController.emailController.text,
                password: managementController.passwordController.text,
                phone: managementController.phoneNumberController.text,
                regionId: managementController.selectedRegion?.id ?? 1,
                monthlyTarget: target ?? 0.0,
                dailyTarget: dailyTarget ?? 0.0,
                type: managementController.selectedType ?? "Cash",
                role: widget.salesman.role,
                status: widget.salesman.status,
                createdAt: widget.salesman.createdAt,
                updatedAt: DateTime.now(),
                imageUrl: widget.salesman.imageUrl,
                totalSales: widget.salesman.totalSales,
                closedDeals: widget.salesman.closedDeals,
                notes: managementController.notesController.text,
              );

              salesmanController.updateSalesman(updatedUser, widget.index);

              showDialog(
                context: context,
                builder: (context) => DialogWidget(
                  title: AppLocalizations.of(context)!.salesman_updated,
                  imageUrl: "assets/images/success.png",
                  actions: [
                    CustomButtonWidget(
                      title: AppLocalizations.of(context)!.ok,
                      onPressed: () {
                        Navigator.pop(context); // Close dialog
                        Navigator.pop(context); // Close screen
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
