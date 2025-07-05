import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/model/salesman.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import 'package:test_sales/controller/lang_controller.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/app_constants.dart';
import 'package:test_sales/view/widgets/home_widgets/card_widget.dart';

class TopSalesmanWidget extends StatelessWidget {
  final List<SalesMan> salesmen;

  const TopSalesmanWidget({super.key, required this.salesmen});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final langCtrl = Provider.of<LangController>(context, listen: false);

    if (salesmen.isEmpty) {
      return Container();
    }

    final topSalesman = salesmen.reduce((current, next) {
      return next.totalSales > current.totalSales ? next : current;
    });

    final langController = Provider.of<LangController>(context, listen: false);

    return CardWidget(
      title: AppLocalizations.of(context)!.top_performer,
      date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      langController: langController,
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              topSalesman.fullName,
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.getFontStyle(langCtrl,
                  fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppConstants.primaryColor2),
            ),
            subtitle: Column(
              children: [
                SizedBox(height: 5.h),
                Text(
                  "${local.total_sales}: ${topSalesman.totalSales.toStringAsFixed(2)} JD",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
                Text(
                  "${local.closed_deals}: ${topSalesman.closedDeals}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
