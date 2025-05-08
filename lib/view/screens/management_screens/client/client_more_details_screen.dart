import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_constants.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import 'package:test_sales/model/client.dart';
import 'package:test_sales/view/widgets/custom_button_widget.dart';
import 'package:test_sales/view/widgets/dialog_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/input_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/main_appbar_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/more_details_widget.dart';
import '../../../../controller/lang_controller.dart';
import '../../../../controller/management_controller.dart';

class ClientMoreDetailsScreen extends StatelessWidget {
  final Client client;
  final int index;

  const ClientMoreDetailsScreen(
      {super.key, required this.client, required this.index});

  @override
  Widget build(BuildContext context) {
    final langController = Provider.of<LangController>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppbarWidget(
        title:
        "${client.tradeName ?? "Name"} - ${AppLocalizations.of(context)!.details}",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // _buildProfileHeader(langController),
              SizedBox(height: 15.h),
              _buildProfileSection(context, langController),
              SizedBox(height: 10.h),
              _buildPerformanceSection(context),
              SizedBox(height: 10.h),
              _buildRecentActivitySection(context),
              SizedBox(height: 10.h),
              _buildAssignedClientsSection(context),
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

  // Widget _buildProfileHeader(LangController langController) {
  //   return Center(
  //     child: Column(
  //       children: [
  //         SizedBox(
  //           height: 120.h,
  //           width: 120.w,
  //           child: CircleAvatar(
  //             backgroundColor: const Color(0xFFE7E7E7),
  //             foregroundImage: AssetImage(
  //                 client.imageUrl ?? "assets/images/default_image.png"),
  //           ),
  //         ),
  //         SizedBox(height: 10.h),
  //       ],
  //     ),
  //   );
  // }

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
        "value": client.tradeName ?? "name"
      },
      {
        "label": AppLocalizations.of(context)!.phone,
        "value": client.phone?.toString() ?? "1246789"
      },
      {
        "label": AppLocalizations.of(context)!.region,
        "value": client.region?.name ?? "region"
      },
      {
        "label": AppLocalizations.of(context)!.status,
        "value": client.status ?? "active"
      },
      {
        "label": AppLocalizations.of(context)!.joining_date,
        "value":
        formatDateWithTime(client.createdAt ?? DateTime.now()).toString()
      },
      {
        "label": AppLocalizations.of(context)!.type,
        "value": client.type ?? "type"
      }
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
            TextEditingController(text: client.type.toString()),
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
            TextEditingController(text: "${client.phone ?? "deals"}"),
            readOnly: true,
            label: AppLocalizations.of(context)!.closed_deals,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 10),
        //   child: InputWidget(
        //     textEditingController: TextEditingController(
        //         text: client.role ?? "achievement"),
        //     readOnly: true,
        //     label: AppLocalizations.of(context)!.targets,
        //   ),
        // )
      ],
    );
  }

  Widget _buildRecentActivitySection(BuildContext context) {
    String formatDateWithTime(DateTime dateTime) {
      final formatter = DateFormat('yyyy-MM-dd | HH:mm');
      return formatter.format(dateTime);
    }

    String getLatestInvoiceAmount() {
      if (client.invoices != null && client.invoices!.isNotEmpty) {
        final latestInvoice = client.invoices!.reduce((current, next) => (next
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
      if (client.visits != null && client.visits!.isNotEmpty) {
        final latestVisit = client.visits!.reduce((current, next) =>
        (next.visitDate?.isAfter(current.visitDate ?? DateTime.now()) ??
            false)
            ? next
            : current);
        return formatDateWithTime(latestVisit.visitDate ?? DateTime.now());
      } else {
        return "No visits available";
      }
    }

    final String latestInvoiceAmount = getLatestInvoiceAmount();
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
          child: client.assignedSalesmen == null || client.assignedSalesmen!.isEmpty
              ? Center(
            child: Text(
              AppLocalizations.of(context)!.no_assigned_clients,
              style: TextStyle(fontSize: 14.sp, color: Colors.black54),
            ),
          )
              : ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: client.assignedSalesmen?.length ?? 0,
            itemBuilder: (context, index) {
              final users = client.assignedSalesmen![index];
              return Column(
                children: [
                  InputWidget(
                    textEditingController: TextEditingController(
                        text: users.fullName ?? "Unknown Client"),
                    label: AppLocalizations.of(context)!.salesman_name,
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

  // Widget _buildSalesReportsSection(BuildContext context) {
  //   String getLatestMonthlySales(Client client) {
  //     if (client.monthlySales != null && client.monthlySales!.isNotEmpty) {
  //       final latestMonthlySales = client.monthlySales!.reduce((current, next) =>
  //       (next.startDate?.isAfter(current.startDate ?? DateTime.now()) ??
  //           false)
  //           ? next
  //           : current);
  //       return latestMonthlySales.totalSales.toString();
  //     } else {
  //       return "No monthly sales data available";
  //     }
  //   }
  //
  //   return MoreDetailsWidget(
  //     title: AppLocalizations.of(context)!.sales_reports,
  //     leadingIcon: Icons.file_copy_outlined,
  //     initExpanded: false,
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
  //         child: InputWidget(
  //           textEditingController: TextEditingController(
  //             text: getLatestMonthlySales(client),
  //           ),
  //           label: AppLocalizations.of(context)!.monthly_sales,
  //           readOnly: true,
  //           suffixIcon: IconButton(
  //             onPressed: () {},
  //             icon: Icon(Icons.arrow_forward_outlined),
  //           ),
  //         ),
  //       ),
  //       SizedBox(
  //         height: 10.h,
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
  //         child: InputWidget(
  //           textEditingController: TextEditingController(),
  //           label: AppLocalizations.of(context)!.product_wise_sales,
  //           readOnly: true,
  //           suffixIcon: IconButton(
  //               onPressed: () {}, icon: Icon(Icons.arrow_forward_outlined)),
  //         ),
  //       ),
  //       SizedBox(
  //         height: 10.h,
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
  //         child: InputWidget(
  //           textEditingController: TextEditingController(),
  //           label: AppLocalizations.of(context)!.top_customers,
  //           readOnly: true,
  //           suffixIcon: IconButton(
  //               onPressed: () {}, icon: Icon(Icons.arrow_forward_outlined)),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildFeedbackSection(BuildContext context) {
    return MoreDetailsWidget(
      title: AppLocalizations.of(context)!.feedback,
      leadingIcon: Icons.location_history_outlined,
      initExpanded: false,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InputWidget(
            height: 100.h,
            textEditingController:
            TextEditingController(text: client.notes ?? ""),
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
                colors: [
                  AppConstants.primaryColor2,
                  AppConstants.primaryColor2
                ],
                borderRadius: 12.r,
                titleColor: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => UpdateSalesmanScreen(
                  //       user: client,
                  //       index: index,
                  //     ),
                  //   ),
                  // );
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<ManagementController>(
          builder: (context, managementController, child) {
            return DialogWidget(
              title: AppLocalizations.of(context)!.confirm_deletion,
              content: AppLocalizations.of(context)!.delete_user,
              imageUrl: "assets/images/cancel.png",
              onPressed: () {
                // managementController.deleteUser(client);
                // Navigator.of(context).pop();
                // Navigator.of(context).pop();
              },
            );
          },
        );
      },
    );
  }
}
