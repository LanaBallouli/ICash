import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/controller/management_controller.dart';
import 'package:test_sales/model/users.dart';
import 'package:test_sales/l10n/app_localizations.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.add_salesman),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _fullNameController,
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.user_name),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.field_required;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.email),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.field_required;
                    } else if (!value.contains('@')) {
                      return AppLocalizations.of(context)!.email_error;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.phone),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.field_required;
                    } else if (value.length < 10) {
                      return AppLocalizations.of(context)!.phone_error;
                    }
                    return null;
                  },
                ),
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
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedStatus,
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.status),
                  items: ["Active", "Inactive"]
                      .map((status) =>
                          DropdownMenuItem(value: status, child: Text(status)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedStatus = value;
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
                      final newSalesman = Users(
                        fullName: _fullNameController.text,
                        email: _emailController.text,
                        phone: int.parse(_phoneController.text),
                        password: _passwordController.text,
                        role: _selectedRole!,
                        status: _selectedStatus!,
                        region: Region(name: _selectedRegion!),
                        totalSales: 0,
                        closedDeals: 0,
                        targetAchievement: 0,
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                        id: 1,
                      );

                      final managementController =
                          Provider.of<ManagementController>(context,
                              listen: false);
                      managementController.addNewUser(newSalesman);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                AppLocalizations.of(context)!.salesman_added)),
                      );

                      Navigator.of(context).pop();
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
