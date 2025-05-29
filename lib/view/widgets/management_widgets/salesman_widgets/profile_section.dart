import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:test_sales/model/salesman.dart';

import '../../../../l10n/app_localizations.dart';
import '../../main_widgets/input_widget.dart';
import '../main/more_details_widget.dart';

class ProfileSection extends StatelessWidget {
  final SalesMan users;

  const ProfileSection({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    String formatDateWithTime(DateTime? dateTime) {
      if (dateTime == null) return "N/A";
      final formatter = DateFormat('yyyy-MM-dd | HH:mm');
      return formatter.format(dateTime);
    }

    final profileDetails = [
      {
        "label": AppLocalizations.of(context)!.user_name,
        "value": users.fullName ?? "N/A",
      },
      {
        "label": AppLocalizations.of(context)!.email,
        "value": users.email ?? "N/A",
      },
      {
        "label": AppLocalizations.of(context)!.phone,
        "value": users.phone?.toString() ?? "N/A",
      },
      {
        "label": AppLocalizations.of(context)!.type,
        "value": users.type ?? "N/A",
      },
      {
        "label": AppLocalizations.of(context)!.region,
        "value": users.region?.name ?? "N/A",
      },
      {
        "label": AppLocalizations.of(context)!.status,
        "value": users.status ?? "N/A",
      },
      {
        "label": AppLocalizations.of(context)!.joining_date,
        "value": formatDateWithTime(users.createdAt),
      },
      {
        "label": AppLocalizations.of(context)!.monthly_target,
        "value": users.monthlyTarget != null
            ? users.monthlyTarget.toString()
            : "N/A",
      },
      {
        "label": AppLocalizations.of(context)!.daily_target,
        "value":
            users.dailyTarget != null ? users.dailyTarget.toString() : "N/A",
      },
    ];

    return MoreDetailsWidget(
      title: AppLocalizations.of(context)!.profile,
      leadingIcon: Icons.person_outline_rounded,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: profileDetails.map((detail) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputWidget(
                    textEditingController:
                        TextEditingController(text: detail["value"]),
                    label: "${detail["label"]}",
                    readOnly: true,
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
