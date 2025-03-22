import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/controller/lang_controller.dart';
import 'package:test_sales/l10n/app_localizations.dart';

import '../../controller/clients_controller.dart';
import '../../controller/product_controller.dart';

class CashInvoiceScreen extends StatefulWidget {
  const CashInvoiceScreen({super.key});

  @override
  State<CashInvoiceScreen> createState() => _CashInvoiceScreenState();
}

class _CashInvoiceScreenState extends State<CashInvoiceScreen> {
  late ProductController productController;
  late ClientsController clientsController;

  @override
  void initState() {
    super.initState();

    clientsController = Provider.of<ClientsController>(context, listen: false);
    productController = Provider.of<ProductController>(context, listen: false);
    clientsController.fetchCashClients();
    productController.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    LangController langController = Provider.of(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.cash_invoice,
          style: AppStyles.getFontStyle(
            context.read<LangController>(),
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.create_invoice_prompt,
            style: AppStyles.getFontStyle(
              context.read<LangController>(),
              color: Colors.black54,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),

        ],
      ),
    );
  }
}
