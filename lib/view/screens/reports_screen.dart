import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/controller/clients_controller.dart';
import 'package:test_sales/controller/invoice_controller.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import 'package:test_sales/view/widgets/home_widgets/invoice_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/main_appbar_widget.dart';

import '../../controller/lang_controller.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  late InvoicesController invoiceController;
  late ClientsController clientsController;

  @override
  void initState() {
    super.initState();
    invoiceController = Provider.of<InvoicesController>(context, listen: false);
    clientsController = Provider.of<ClientsController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData(context);
    });
  }

  Future<void> _loadData(BuildContext context) async {
    try {
      await invoiceController.fetchAllInvoices();
      await clientsController.fetchAllClients();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text(AppLocalizations.of(context)!.error_loading_invoices)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final langCtrl = Provider.of<LangController>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppbarWidget(title: local.all_invoices),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),

            // 🔹 List of Invoices
            Expanded(
              child: Consumer<InvoicesController>(
                builder: (context, ctrl, _) {
                  if (ctrl.isLoading && ctrl.invoices.isEmpty) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (ctrl.errorMessage != null) {
                    return Center(
                      child: Text(ctrl.errorMessage!,
                          style: TextStyle(color: Colors.red)),
                    );
                  }

                  if (ctrl.invoices.isEmpty) {
                    return Center(
                      child: Text(local.no_invoices_found),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () => invoiceController.fetchAllInvoices(),
                    child: ListView.builder(
                      itemCount: ctrl.invoices.length,
                      itemBuilder: (context, index) {
                        final invoice = ctrl.invoices[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: InvoiceWidget(invoice: invoice),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
