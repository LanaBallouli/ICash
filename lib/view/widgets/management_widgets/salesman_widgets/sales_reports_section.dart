import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../controller/invoice_controller.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../model/salesman.dart';
import '../../main_widgets/input_widget.dart';
import '../main/more_details_widget.dart';

class SalesReportsSection extends StatelessWidget {
  final SalesMan users;

  const SalesReportsSection({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    final invoicesController = Provider.of<InvoicesController>(context);
    final local = AppLocalizations.of(context)!;

    // Load salesman's invoices when screen loads
    if (!invoicesController.isLoading && invoicesController.invoices.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (users.id != null) {
          invoicesController.fetchInvoicesBySalesman(users.id!);
        }
      });
    }

    return MoreDetailsWidget(
      title: local.sales_reports,
      leadingIcon: Icons.file_copy_outlined,
      children: [
        // --- Monthly Target Achievement ---
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InputWidget(
            textEditingController: TextEditingController(text: _getMonthlyTargetAchievement(users)),
            label: local.monthly_target_achievement,
            readOnly: true,
          ),
        ),
        SizedBox(height: 10.h),

        // --- Total Sales for This Month ---
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InputWidget(
            textEditingController: TextEditingController(text: _getTotalMonthlySales(invoicesController, context)),
            label: local.monthly_sales,
            readOnly: true,
            suffixIcon: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward_outlined),
            ),
          ),
        ),
        SizedBox(height: 10.h),

        // --- Product-wise Sales (Coming Soon) ---
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InputWidget(
            textEditingController: TextEditingController(text: "local.coming_soon"),
            label: local.product_wise_sales,
            readOnly: true,
            suffixIcon: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward_outlined),
            ),
          ),
        ),
        SizedBox(height: 10.h),

        // --- Top Customers (Coming Soon) ---
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InputWidget(
            textEditingController: TextEditingController(text: "local.coming_soon"),
            label: local.top_customers,
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

  /// Helper to get percentage of target achieved
  String _getMonthlyTargetAchievement(SalesMan user) {
    if (user.monthlyTarget == 0.0 || user.totalSales == 0.0) {
      return "N/A";
    }
    final percent = ((user.totalSales / user.monthlyTarget) * 100).toStringAsFixed(2);
    return "$percent%";
  }

  /// Helper to calculate only this month's sales
  String _getTotalMonthlySales(InvoicesController invoicesCtrl, BuildContext context) {
    if (invoicesCtrl.isLoading) {
      return "AppLocalizations.of(context)!.loading";
    }

    final now = DateTime.now();
    final monthlySales = invoicesCtrl.invoices
        .where((invoice) =>
    invoice.creationTime.year == now.year &&
        invoice.creationTime.month == now.month)
        .toList();

    if (monthlySales.isEmpty) {
      return "0 JD";
    }

    final total = monthlySales.map((i) => i.total).reduce((a, b) => a + b);
    return "${total.toStringAsFixed(2)} JD";
  }
}