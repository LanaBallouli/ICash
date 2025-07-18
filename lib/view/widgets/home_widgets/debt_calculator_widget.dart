import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
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

    final debtInvoices = invoices
        .where((invoice) => invoice.type == "Debt")
        .where((invoice) => invoice.status != "Paid")
        .toList();

    double totalDebt = debtInvoices.map((i) => i.total).sum;

    return CardWidget(
      title: local.total_debt,
      date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      langController: langCtrl,
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "total outstanding: ${totalDebt.toStringAsFixed(2)} JD",
            textAlign: TextAlign.center,
            style: AppStyles.getFontStyle(
              langCtrl,
              color: totalDebt > 0 ? Colors.red : Colors.green,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15.h),
        ],
      ),
    );
  }
}