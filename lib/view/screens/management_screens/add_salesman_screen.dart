import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_constants.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/controller/lang_controller.dart';
import 'package:test_sales/controller/management_controller.dart';
import 'package:test_sales/model/users.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import 'package:test_sales/view/widgets/custom_button_widget.dart';
import 'package:test_sales/view/widgets/dialog_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/input_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/main_appbar_widget.dart';
import 'package:test_sales/view/widgets/registration_widgets/email_field_widget.dart';
import 'package:test_sales/view/widgets/registration_widgets/name_input_widget.dart';
import 'package:test_sales/view/widgets/registration_widgets/password_field_widget.dart';
import 'package:test_sales/view/widgets/registration_widgets/phone_input_widget.dart';
import '../../../controller/login_controller.dart';
import '../../../model/region.dart';

class AddSalesmanScreen extends StatefulWidget {
  const AddSalesmanScreen({super.key});

  @override
  _AddSalesmanScreenState createState() => _AddSalesmanScreenState();
}

class _AddSalesmanScreenState extends State<AddSalesmanScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _selectedRole;
  String? _selectedStatus;
  String? _selectedRegion;
  late LoginController loginController =
      Provider.of<LoginController>(context, listen: false);

  @override
  void initState() {
    super.initState();
    loginController.clearFields();
  }

  @override
  Widget build(BuildContext context) {
    final langController = Provider.of<LangController>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          MainAppbarWidget(title: AppLocalizations.of(context)!.add_salesman),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Form(
          key: _formKey,
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
                  hintText: AppLocalizations.of(context)!.enter_salesman_name,
                ),
                EmailFieldWidget(),
                PasswordFieldWidget(
                  hintText:
                      AppLocalizations.of(context)!.enter_salesman_password,
                ),
                PhoneInputWidget(),
                SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.password),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.field_required;
                    } else if (value.length < 8) {
                      return AppLocalizations.of(context)!.password_error;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedRole,
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.role),
                  items: ["Salesman", "Admin"]
                      .map((role) =>
                          DropdownMenuItem(value: role, child: Text(role)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedRole = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.field_required;
                    }
                    return null;
                  },
                ),
                // SizedBox(height: 16),
                // DropdownButtonFormField<String>(
                //   value: _selectedStatus,
                //   decoration: InputDecoration(
                //       labelText: AppLocalizations.of(context)!.status),
                //   items: ["Active", "Inactive"]
                //       .map((status) =>
                //           DropdownMenuItem(value: status, child: Text(status)))
                //       .toList(),
                //   onChanged: (value) {
                //     setState(() {
                //       _selectedStatus = value;
                //     });
                //   },
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return AppLocalizations.of(context)!.field_required;
                //     }
                //     return null;
                //   },
                // ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedRegion,
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.region),
                  items: ["Amman", "New York", "Los Angeles"]
                      .map((region) =>
                          DropdownMenuItem(value: region, child: Text(region)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedRegion = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.field_required;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!
                          .save(); // Save form state if using onSaved

                      try {
                        // Create the new salesman object
                        final newSalesman = Users(
                          fullName: _fullNameController.text,
                          email: _emailController.text,
                          phone: int.tryParse(_phoneController.text) ?? 0,
                          // Handle invalid input gracefully
                          password: _passwordController.text,
                          role: _selectedRole!,
                          status: _selectedStatus!,
                          region: Region(name: _selectedRegion!),
                          totalSales: 0,
                          closedDeals: 0,
                          targetAchievement: 0,
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                          id: UniqueKey()
                              .hashCode, // Generate a unique ID dynamically
                        );

                        // Add the new salesman to the management controller
                        final managementController =
                            Provider.of<ManagementController>(context,
                                listen: false);
                        managementController.addNewUser(newSalesman);

                        Navigator.of(context).pop();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return DialogWidget(
                              title: AppLocalizations.of(context)!
                                  .salesman_creation,
                              imageUrl: "assets/images/success.png",
                              backgroundColor: Color(0xFFFAFEF9),
                              actions: [
                                CustomButtonWidget(
                                  title: AppLocalizations.of(context)!.ok,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  colors: [
                                    AppConstants.primaryColor2,
                                    AppConstants.primaryColor2
                                  ],
                                  borderRadius: 12.r,
                                )
                              ],
                            );
                          },
                        );
                      } catch (e) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return DialogWidget(
                              title: AppLocalizations.of(context)!
                                  .error_adding_salesman,
                              imageUrl: "assets/images/cancel.png",
                              backgroundColor: Color(0xFFFEF2EE),
                              actions: [
                                CustomButtonWidget(
                                  title: AppLocalizations.of(context)!.ok,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  colors: [
                                    AppConstants.primaryColor2,
                                    AppConstants.primaryColor2
                                  ],
                                )
                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                  child: Text(AppLocalizations.of(context)!.save),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
