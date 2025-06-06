import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_sales/model/salesman.dart';
import '../../../../l10n/app_localizations.dart';
import '../../main_widgets/input_widget.dart';
import '../main/more_details_widget.dart';

class PerformanceSection extends StatelessWidget {
  final SalesMan salesman;

  const PerformanceSection({super.key, required this.salesman});

  @override
  Widget build(BuildContext context) {
    return MoreDetailsWidget(
      title: AppLocalizations.of(context)!.performance,
      leadingIcon: Icons.assessment_outlined,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: InputWidget(
            textEditingController:
                TextEditingController(text: salesman.totalSales.toString()),
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
                TextEditingController(text: "${salesman.closedDeals ?? "deals"}"),
            readOnly: true,
            label: AppLocalizations.of(context)!.closed_deals,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 10),
        //   child: MoreDetailsWidget(
        //     title: AppLocalizations.of(context)!.summary_of_top_customers,
        //     backgroundColor: Color(0xFFECF0F6),
        //     children: [
        //       ListView.builder(
        //         itemBuilder: (context, index) {
        //           return InputWidget(
        //               textEditingController: TextEditingController());
        //         },
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
