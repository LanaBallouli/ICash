import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_constants.dart';
import 'package:test_sales/controller/salesman_controller.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import 'package:test_sales/model/salesman.dart';
import 'package:test_sales/view/screens/management_screens/salesmen_screens/update_salesman_screen.dart';
import 'package:test_sales/view/widgets/main_widgets/custom_button_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/dialog_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/input_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/main_appbar_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/main/more_details_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/salesman_widgets/assigned_clients_section.dart';
import 'package:test_sales/view/widgets/management_widgets/salesman_widgets/performance_section.dart';
import 'package:test_sales/view/widgets/management_widgets/salesman_widgets/profile_section.dart';
import 'package:test_sales/view/widgets/management_widgets/salesman_widgets/recent_activity_section.dart';
import 'package:test_sales/view/widgets/management_widgets/salesman_widgets/sales_reports_section.dart';
import '../../../../app_styles.dart';
import '../../../../controller/lang_controller.dart';
import '../../../../controller/management_controller.dart';

class SalesmenMoreDetailsScreen extends StatelessWidget {
  final SalesMan users;
  final int index;

  const SalesmenMoreDetailsScreen(
      {super.key, required this.users, required this.index});

  @override
  Widget build(BuildContext context) {
    final langController = Provider.of<LangController>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppbarWidget(
        title:
            "${users.fullName ?? "Name"} - ${AppLocalizations.of(context)!.details}",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileHeader(langController),
              SizedBox(height: 15.h),
              ProfileSection(salesman: users),
              SizedBox(height: 10.h),
              PerformanceSection(salesman: users),
              SizedBox(height: 10.h),
              RecentActivitySection(salesman: users),
              SizedBox(height: 10.h),
              AssignedClientsSection(salesman: users),
              SizedBox(height: 10.h),
              SalesReportsSection(users: users),
              SizedBox(height: 10.h),
              _buildFeedbackSection(context),
              SizedBox(height: 20.h),
              _buildButtonsRow(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(LangController langController) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 120.h,
            width: 120.w,
            child: CircleAvatar(
              backgroundColor: const Color(0xFFE7E7E7),
              foregroundImage: AssetImage(
                  users.imageUrl ?? "assets/images/default_image.png"),
            ),
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  Widget _buildFeedbackSection(BuildContext context) {
    return MoreDetailsWidget(
      title: AppLocalizations.of(context)!.feedback,
      leadingIcon: Icons.location_history_outlined,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InputWidget(
            height: 100.h,
            textEditingController:
                TextEditingController(text: users.notes ?? ""),
            label: AppLocalizations.of(context)!.notes,
            readOnly: true,
            maxLines: 3,
          ),
        )
      ],
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
                title: AppLocalizations.of(context)!.update,
                color:AppConstants.primaryColor2,
                borderRadius: 12.r,
                titleColor: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateSalesmanScreen(
                        salesman: users,
                        index: index,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        SizedBox(
          width: 20.h,
        ),
        Expanded(
          child: CustomButtonWidget(
            title:AppLocalizations.of(context)!.delete_salesman,
            color:Color(0xFF910000),
            borderRadius: 12.r,
            titleColor: Colors.white,
            fontSize: 15.sp,
            onPressed: () {
              _deleteCurrentUser(context);
            },
          ),
        )
      ],
    );
  }

  void _deleteCurrentUser(BuildContext context) {
    final langController = Provider.of<LangController>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<SalesmanController>(
          builder: (context, salesmanController, child) {
            return DialogWidget(
              title: AppLocalizations.of(context)!.confirm_deletion,
              content:Text(
                AppLocalizations.of(context)!.delete_user,
                textAlign: TextAlign.center,
                style: AppStyles.getFontStyle(
                  langController,
                  fontSize: 12,
                  color: Colors.black45,
                  fontWeight: FontWeight.w400,
                ),
              ),
              imageUrl: "assets/images/cancel.png",
              onPressed: () {
                salesmanController.deleteSalesman(users.id!);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            );
          },
        );
      },
    );
  }
}
