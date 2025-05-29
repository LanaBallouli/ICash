import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:test_sales/model/users.dart';
import '../../../../l10n/app_localizations.dart';
import '../../main_widgets/input_widget.dart';
import '../main/more_details_widget.dart';

class RecentActivitySection extends StatelessWidget {
  final Users users;
  const RecentActivitySection({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    String formatDateWithTime(DateTime dateTime) {
      final formatter = DateFormat('yyyy-MM-dd | HH:mm');
      return formatter.format(dateTime);
    }

    String _getLatestInvoiceAmount() {
      if (users.invoices != null && users.invoices!.isNotEmpty) {
        final latestInvoice = users.invoices!.reduce((current, next) => (next
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
      if (users.visits != null && users.visits!.isNotEmpty) {
        final latestVisit = users.visits!.reduce((current, next) =>
        (next.visitDate?.isAfter(current.visitDate ?? DateTime.now()) ??
            false)
            ? next
            : current);
        return formatDateWithTime(latestVisit.visitDate ?? DateTime.now());
      } else {
        return "No visits available";
      }
    }

    final String latestInvoiceAmount = _getLatestInvoiceAmount();
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
}
