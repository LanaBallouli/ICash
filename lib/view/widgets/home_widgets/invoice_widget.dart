import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:test_sales/app_constants.dart';
import 'package:test_sales/controller/clients_controller.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import 'package:test_sales/controller/lang_controller.dart';
import 'package:test_sales/model/invoice.dart';
import 'package:test_sales/app_styles.dart';
import 'package:provider/provider.dart';

class InvoiceWidget extends StatelessWidget {
  final Invoice invoice;

  const InvoiceWidget({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final langCtrl = Provider.of<LangController>(context, listen: false);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppConstants.buttonColor,
      ),
      padding: EdgeInsets.all(16.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "#${invoice.invoiceNumber}",
                style: AppStyles.getFontStyle(langCtrl,
                    fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              Chip(
                label: Text(invoice.status),
                backgroundColor: _getStatusColor(invoice.status),
              ),
            ],
          ),
          SizedBox(height: 10.h),

          // 🔹 Client Name
          Consumer<ClientsController>(
            builder: (context, clientsController, child) {
              return Text(
                "${local.client}: ${clientsController.getClientById(invoice.clientId)?.tradeName ?? local.no_client}",
                style: AppStyles.getFontStyle(langCtrl, fontSize: 14.sp),
              );
            },
          ),
          SizedBox(height: 5.h),

          Text(
            "${local.issue_date}: ${DateFormat('yyyy-MM-dd').format(invoice.issueDate)}",
            style: AppStyles.getFontStyle(langCtrl, fontSize: 14.sp),
          ),
          SizedBox(height: 5.h),

          Text(
            "${local.due_date}: ${DateFormat('yyyy-MM-dd').format(invoice.dueDate)}",
            style: AppStyles.getFontStyle(langCtrl, fontSize: 14.sp),
          ),
          SizedBox(height: 10.h),

          Divider(color: Colors.black26),

          SizedBox(height: 10.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${local.total}: ${invoice.total.toStringAsFixed(2)} JD",
                style: AppStyles.getFontStyle(langCtrl,
                    fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(
                    context, '/invoice-details',
                    arguments: invoice),
                icon: Icon(
                  Icons.receipt_long,
                  size: 16.sp,
                  color: Colors.white,
                ),
                label: Text(local.view_details,
                    style: TextStyle(fontSize: 12.sp, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.primaryColor2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "paid":
        return Colors.green;
      case "pending":
        return Colors.orange.shade100;
      case "overdue":
        return Colors.red.shade100;
      default:
        return Colors.grey.shade300;
    }
  }
}
