import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/model/salesman.dart';
import '../../../../controller/invoice_controller.dart';
import '../../../../controller/visit_controller.dart';
import '../../../../l10n/app_localizations.dart';
import '../../main_widgets/input_widget.dart';
import '../main/more_details_widget.dart';

class RecentActivitySection extends StatelessWidget {
  final SalesMan salesman;

  const RecentActivitySection({super.key, required this.salesman});

  @override
  Widget build(BuildContext context) {
    final invoicesController = Provider.of<InvoicesController>(context);
    final visitsController = Provider.of<VisitsController>(context);

    if (invoicesController.isLoading && invoicesController.invoices.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (salesman.id != null) {
          invoicesController.fetchInvoicesBySalesman(salesman.id!);
        }
      });
    }

    if (visitsController.isLoading && visitsController.visits.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (salesman.id != null) {
          visitsController.fetchVisitsBySalesman(salesman.id!);
        }
      });
    }

    return _buildContent(context, invoicesController, visitsController);
  }

  Widget _buildContent(
      BuildContext context,
      InvoicesController invoicesCtrl,
      VisitsController visitsCtrl,
      ) {
    final local = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    String formatDateWithTime(DateTime? dateTime) {
      final formatter = DateFormat('yyyy-MM-dd | HH:mm');
      return dateTime != null ? formatter.format(dateTime) : "N/A";
    }

    String getLatestInvoiceAmount() {
      if (invoicesCtrl.invoices.isNotEmpty) {
        final latest = invoicesCtrl.invoices.reduce((a, b) =>
        a.creationTime.isAfter(b.creationTime) ? a : b);
        return "${latest.total.toStringAsFixed(2)} JD";
      }
      return local.no_invoices_available;
    }

    String getLatestVisitDate() {
      if (visitsCtrl.visits.isNotEmpty) {
        final latest = visitsCtrl.visits.reduce((a, b) =>
        a.visitDate.isAfter(b.visitDate) ? a : b);
        return formatDateWithTime(latest.visitDate);
      }
      return local.no_visits_yet;
    }

    String getNextVisitDate() {
      final upcoming = visitsCtrl.visits
          .where((v) => v.nextVisitTime?.isAfter(DateTime.now()) ?? false)
          .toList();

      if (upcoming.isNotEmpty) {
        final next = upcoming.reduce((a, b) =>
        (a.nextVisitTime ?? DateTime.now()).isBefore(b.nextVisitTime ?? DateTime.now())
            ? a
            : b);
        return formatDateWithTime(next.nextVisitTime);
      }
      return local.no_next_visits_scheduled;
    }

    final latestInvoiceAmount = getLatestInvoiceAmount();
    final latestVisitDate = getLatestVisitDate();
    final nextVisitDate = getNextVisitDate();

    return MoreDetailsWidget(
      title: local.recent_activity_log,
      leadingIcon: Icons.access_time,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InputWidget(
            textEditingController: TextEditingController(text: latestInvoiceAmount),
            label: local.latest_invoice,
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
            label: local.latest_visit,
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
            textEditingController: TextEditingController(text: nextVisitDate),
            label: local.next_visit,
            readOnly: true,
            suffixIcon: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward_outlined),
            ),
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}