import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_sales/model/users.dart';

import '../../../../l10n/app_localizations.dart';
import '../../main_widgets/input_widget.dart';
import '../main/more_details_widget.dart';

class PerformanceSection extends StatelessWidget {
  final Users users;

  const PerformanceSection({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
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
      ],
    );
  }
}
