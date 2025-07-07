import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_constants.dart';
import 'package:test_sales/model/invoice.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import 'package:test_sales/controller/lang_controller.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/view/widgets/home_widgets/card_widget.dart';

class DebtCardWidget extends StatelessWidget {
  final List<Invoice> invoices;

  const DebtCardWidget({super.key, required this.invoices});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final langCtrl = Provider.of<LangController>(context, listen: false);

    final unpaidInvoices =
        invoices.where((invoice) => invoice.status != "Paid").toList();

    double totalDebt = unpaidInvoices.map((i) => i.total).sum;

    final langController = Provider.of<LangController>(context, listen: false);

    return CardWidget(
        title: local.total_debt,
        date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        langController: langController,
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 8.h,),
            Text(
              "$totalDebt ${local.jd}",
              style: AppStyles.getFontStyle(
                langCtrl,
                color:
                    totalDebt > 0 ? Colors.red : AppConstants.primaryColor2,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15.h),
            if (unpaidInvoices.isNotEmpty)
              ...unpaidInvoices.map((invoice) {
                final isOverdue = invoice.dueDate.isBefore(DateTime.now());

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: ListTile(
                    leading: Icon(
                      isOverdue
                          ? Icons.warning_amber_rounded
                          : Icons.pending_actions,
                      color: isOverdue ? Colors.red : Colors.orange,
                    ),
                    title: Text(
                      "${local.invoice} #${invoice.invoiceNumber}",
                      style:
                          AppStyles.getFontStyle(langCtrl, fontSize: 14.sp),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${local.amount}: ${invoice.total} JD"),
                        Text(
                            "${"local.due_date"}: ${DateFormat('yyyy-MM-dd').format(invoice.dueDate)}"),
                      ],
                    ),
                    trailing: Text(
                      "${invoice.total} JD",
                      style: TextStyle(
                        color: isOverdue ? Colors.red : Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                );
              })
            else
              Text(local.no_unpaid_invoices),
          ],
        ));
  }
}
