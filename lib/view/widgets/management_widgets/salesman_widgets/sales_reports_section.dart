import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../model/salesman.dart';
import '../../main_widgets/input_widget.dart';
import '../main/more_details_widget.dart';

class SalesReportsSection extends StatelessWidget {
  final SalesMan users;
  const SalesReportsSection({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    String getLatestMonthlySales(SalesMan users) {
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
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InputWidget(
            textEditingController: TextEditingController(
              text: getLatestMonthlySales(users),
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: InputWidget(
            textEditingController: TextEditingController(
                text: "${users.monthlyTarget ?? "monthly achievement"}"),
            readOnly: true,
            label: AppLocalizations.of(context)!.monthly_target_achievement,
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
}
