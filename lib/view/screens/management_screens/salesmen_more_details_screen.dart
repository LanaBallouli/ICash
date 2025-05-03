import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_constants.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import 'package:test_sales/model/users.dart';
import 'package:test_sales/view/widgets/custom_button_widget.dart';
import 'package:test_sales/view/widgets/dialog_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/input_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/main_appbar_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/more_details_widget.dart';
import '../../../app_styles.dart';
import '../../../controller/lang_controller.dart';
import '../../../controller/management_controller.dart';

class SalesmenMoreDetailsScreen extends StatelessWidget {
  final Users users;

  const SalesmenMoreDetailsScreen({super.key, required this.users});

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
              _buildProfileSection(context, langController),
              SizedBox(height: 10.h),
              _buildPerformanceSection(context),
              SizedBox(height: 10.h),
              _buildRecentActivitySection(context),
              SizedBox(height: 10.h),
              _buildAssignedClientsSection(context),
              SizedBox(height: 10.h),
              _buildSalesReportsSection(context),
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

  Widget _buildProfileSection(
      BuildContext context, LangController langController) {
    return MoreDetailsWidget(
      title: AppLocalizations.of(context)!.profile,
      leadingIcon: Icons.person_outline_rounded,
      initExpanded: false,
      children: _buildProfileInputs(context, langController),
    );
  }

  List<Widget> _buildProfileInputs(
      BuildContext context, LangController langController) {
    String formatDateWithTime(DateTime dateTime) {
      final formatter = DateFormat('yyyy-MM-dd | HH:mm');
      return formatter.format(dateTime);
    }

    final profileDetails = [
      {
        "label": AppLocalizations.of(context)!.user_name,
        "value": users.fullName ?? "name"
      },
      {
        "label": AppLocalizations.of(context)!.email,
        "value": users.email ?? "email"
      },
      {
        "label": AppLocalizations.of(context)!.phone,
        "value": users.phone?.toString() ?? "1246789"
      },
      {"label": AppLocalizations.of(context)!.role, "value": users.role},
      {
        "label": AppLocalizations.of(context)!.region,
        "value": users.region?.name ?? "region"
      },
      {
        "label": AppLocalizations.of(context)!.status,
        "value": users.status ?? "active"
      },
      {
        "label": AppLocalizations.of(context)!.joining_date,
        "value":
            formatDateWithTime(users.createdAt ?? DateTime.now()).toString()
      },
    ];

    return profileDetails.map((detail) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            InputWidget(
              textEditingController:
                  TextEditingController(text: detail["value"] ?? ""),
              label: "${detail["label"]}",
              readOnly: true,
            ),
            SizedBox(
              height: 10.h,
            )
          ],
        ),
      );
    }).toList();
  }

  Widget _buildPerformanceSection(BuildContext context) {
    return MoreDetailsWidget(
      title: AppLocalizations.of(context)!.performance,
      leadingIcon: Icons.assessment_outlined,
      initExpanded: false,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: InputWidget(
            textEditingController:
                TextEditingController(text: users.totalSales.toString()),
            readOnly: true,
            label: AppLocalizations.of(context)!.total_sales,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: InputWidget(
            textEditingController:
                TextEditingController(text: "${users.closedDeals ?? "deals"}"),
            readOnly: true,
            label: AppLocalizations.of(context)!.closed_deals,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: InputWidget(
            textEditingController: TextEditingController(
                text: "${users.targetAchievement ?? "achievement"}"),
            readOnly: true,
            label: AppLocalizations.of(context)!.targets,
          ),
        )
      ],
    );
  }

  Widget _buildRecentActivitySection(BuildContext context) {
    String formatDateWithTime(DateTime dateTime) {
      final formatter = DateFormat('yyyy-MM-dd | HH:mm');
      return formatter.format(dateTime);
    }

    String _getLatestInvoiceAmount() {
      if (users.invoices != null && users.invoices!.isNotEmpty) {
        final latestInvoice = users.invoices!.reduce((current, next) => (next
                    .creationTime
                    ?.isAfter(current.creationTime ?? DateTime.now()) ??
                false)
            ? next
            : current);
        return latestInvoice.calculateTotalAmount().toString();
      } else {
        return "No invoices available";
      }
    }

    String getLatestVisitDate() {
      if (users.visits != null && users.visits!.isNotEmpty) {
        final latestVisit = users.visits!.reduce((current, next) =>
            (next.visitDate?.isAfter(current.visitDate ?? DateTime.now()) ??
                    false)
                ? next
                : current);
        return formatDateWithTime(latestVisit.visitDate ?? DateTime.now());
      } else {
        return "No visits available";
      }
    }

    final String latestInvoiceAmount = _getLatestInvoiceAmount();
    final String latestVisitDate = getLatestVisitDate();

    return MoreDetailsWidget(
      title: AppLocalizations.of(context)!.recent_activity_log,
      leadingIcon: Icons.access_time,
      initExpanded: false,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InputWidget(
            textEditingController:
                TextEditingController(text: latestInvoiceAmount),
            label: AppLocalizations.of(context)!.latest_invoice,
            readOnly: true,
            suffixIcon: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward_outlined),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InputWidget(
            textEditingController: TextEditingController(text: latestVisitDate),
            label: AppLocalizations.of(context)!.latest_visit,
            readOnly: true,
            suffixIcon: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward_outlined),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InputWidget(
            textEditingController: TextEditingController(),
            label: AppLocalizations.of(context)!.login_history,
            readOnly: true,
            suffixIcon: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward_outlined),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InputWidget(
            textEditingController: TextEditingController(),
            label: AppLocalizations.of(context)!.task_completion,
            readOnly: true,
            suffixIcon: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward_outlined),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAssignedClientsSection(BuildContext context) {
    return MoreDetailsWidget(
      title: AppLocalizations.of(context)!.assigned_clients,
      leadingIcon: Icons.groups_2_outlined,
      initExpanded: false,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: users.clients == null || users.clients!.isEmpty
              ? Center(
                  child: Text(
                    AppLocalizations.of(context)!.no_assigned_clients,
                    style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: users.clients?.length ?? 0,
                  itemBuilder: (context, index) {
                    final client = users.clients![index];
                    return Column(
                      children: [
                        InputWidget(
                          textEditingController: TextEditingController(
                              text: client.tradeName ?? "Unknown Client"),
                          label: AppLocalizations.of(context)!.client_name,
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_forward)),
                          readOnly: true,
                        ),
                        SizedBox(
                          height: 10.h,
                        )
                      ],
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildSalesReportsSection(BuildContext context) {
    String _getLatestMonthlySales(Users users) {
      if (users.monthlySales != null && users.monthlySales!.isNotEmpty) {
        final latestMonthlySales = users.monthlySales!.reduce((current, next) =>
            (next.startDate?.isAfter(current.startDate ?? DateTime.now()) ??
                    false)
                ? next
                : current);
        return latestMonthlySales.totalSales.toString();
      } else {
        return "No monthly sales data available";
      }
    }

    return MoreDetailsWidget(
      title: AppLocalizations.of(context)!.sales_reports,
      leadingIcon: Icons.file_copy_outlined,
      initExpanded: false,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InputWidget(
            textEditingController: TextEditingController(
              text: _getLatestMonthlySales(users),
            ),
            label: AppLocalizations.of(context)!.monthly_sales,
            readOnly: true,
            suffixIcon: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward_outlined),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InputWidget(
            textEditingController: TextEditingController(),
            label: AppLocalizations.of(context)!.product_wise_sales,
            readOnly: true,
            suffixIcon: IconButton(
                onPressed: () {}, icon: Icon(Icons.arrow_forward_outlined)),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InputWidget(
            textEditingController: TextEditingController(),
            label: AppLocalizations.of(context)!.top_customers,
            readOnly: true,
            suffixIcon: IconButton(
                onPressed: () {}, icon: Icon(Icons.arrow_forward_outlined)),
          ),
        ),
      ],
    );
  }

  Widget _buildFeedbackSection(BuildContext context) {
    return MoreDetailsWidget(
      title: AppLocalizations.of(context)!.feedback,
      leadingIcon: Icons.location_history_outlined,
      initExpanded: false,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InputWidget(
            textEditingController:
                TextEditingController(text: users.notes ?? ""),
            label: "ملاحظة من لانا",
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
          child: CustomButtonWidget(
            title: "Update",
            colors: [AppConstants.primaryColor2, AppConstants.primaryColor2],
            borderRadius: 12.r,
            titleColor: Colors.white,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            onPressed: () {},
          ),
        ),
        SizedBox(
          width: 20.h,
        ),
        Expanded(
          child: CustomButtonWidget(
            title: "Delete User",
            colors: [Color(0xFF910000), Color(0xFF910000)],
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
        return Consumer<ManagementController>(
          builder: (context, managementController, child) {
            return DialogWidget(
              title: AppLocalizations.of(context)!.confirm_deletion,
              content: Text(
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
                managementController.deleteUser(users);
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
