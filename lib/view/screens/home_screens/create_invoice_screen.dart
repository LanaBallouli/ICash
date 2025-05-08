import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/controller/Invoice_controller.dart';
import 'package:test_sales/controller/clients_controller.dart';
import 'package:test_sales/controller/lang_controller.dart';
import 'package:test_sales/controller/product_controller.dart';
import 'package:test_sales/view/widgets/home_widgets/add_item_sheet.dart';
import 'package:test_sales/view/widgets/main_widgets/input_widget.dart';
import 'package:test_sales/view/widgets/home_widgets/invoice_drop_down.dart';
import '../../../l10n/app_localizations.dart';
import '../../widgets/home_widgets/invoice_row_widget.dart';

class CreateInvoiceScreen extends StatefulWidget {
  const CreateInvoiceScreen({super.key});

  @override
  State<CreateInvoiceScreen> createState() => _CreateInvoiceScreenState();
}

class _CreateInvoiceScreenState extends State<CreateInvoiceScreen> {
  late ProductController productController;
  late ClientsController clientsController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final clients = Provider.of<ClientsController>(context, listen: false);
      final products = Provider.of<ProductController>(context, listen: false);
      clientsController = clients;
      productController = products;
      // clientsController.fetchCashClients();
      // clientsController.fetchDebtClients();
      productController.fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: const Color(0xFFFAFAFA),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildPromptText(context),
              SizedBox(height: 10.h),
              _buildInvoiceForm(context),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    LangController langController =
        Provider.of<LangController>(context, listen: false);
    return AppBar(
      backgroundColor: const Color(0xFFFAFAFA),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back_sharp),
      ),
      centerTitle: true,
      title: Text(
        AppLocalizations.of(context)!.create_invoice,
        style: AppStyles.getFontStyle(
          langController,
          fontWeight: FontWeight.w600,
          color: Colors.black,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildPromptText(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Text(
        AppLocalizations.of(context)!.create_invoice_prompt,
        style: AppStyles.getFontStyle(
          context.read<LangController>(),
          color: Colors.black54,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildInvoiceForm(BuildContext context) {
    final invoiceProvider = context.watch<InvoiceController>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
      child: Column(
        children: [
          _buildInvoiceTypeRow(context),
          SizedBox(height: 15.h),
          _buildInvoiceNumber(context),
          SizedBox(height: 15.h),
          if (invoiceProvider.invoiceType == 'debt')
            _buildStaticField(
              title: AppLocalizations.of(context)!.tax_number,
              value: "132131",
            ),
          if (invoiceProvider.invoiceType == 'debt') SizedBox(height: 15.h),
          // _buildClientDropdown(context),
          SizedBox(height: 15.h),
          _buildProductDropdown(context),
          SizedBox(height: 15.h),
          if (invoiceProvider.invoiceType == 'debt') _buildTaxField(context),
          if (invoiceProvider.invoiceType == 'debt') SizedBox(height: 15.h),
          _buildDiscountField(context),
          SizedBox(height: 15.h),
        ],
      ),
    );
  }

  Widget _buildInvoiceTypeRow(BuildContext context) {
    LangController langController =
        Provider.of<LangController>(context, listen: false);
    return Consumer<InvoiceController>(
      builder: (context, invoiceController, child) {
        return InvoiceRowWidget(
          widget: SingleChildScrollView(
            child: SizedBox(
              width: 220.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 50.h,
                    width: 100.w,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                          invoiceController.cashColor!,
                        ),
                      ),
                      onPressed: () {
                        // invoiceController.setSelectedInvoiceType('cash');
                        invoiceController.setInvoiceTypeColor(true);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.cash,
                        style: AppStyles.getFontStyle(
                          langController,
                          color: invoiceController.cashTextColor!,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                    width: 100.w,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(invoiceController.debtColor!),
                      ),
                      onPressed: () {
                        // invoiceController.setSelectedInvoiceType('debt');
                        invoiceController.setInvoiceTypeColor(false);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.debt,
                        style: AppStyles.getFontStyle(
                          langController,
                          color: invoiceController.debtTextColor!,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          title: AppLocalizations.of(context)!.invoice_type,
        );
      },
    );
  }

  Widget _buildInvoiceNumber(BuildContext context) {
    return Consumer<InvoiceController>(
      builder: (context, invoiceController, child) {
        return FutureBuilder<int>(
          future: invoiceController.getNextInvoiceNumber(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(
                child: Text(AppLocalizations.of(context)!.error_loading_data),
              );
            } else {
              final int nextInvoiceNumber = snapshot.data ?? 0;
              return _buildStaticField(
                title: AppLocalizations.of(context)!.invoice_num,
                value: "INV-$nextInvoiceNumber",
              );
            }
          },
        );
      },
    );
  }

  // Widget _buildClientDropdown(BuildContext context) {
  //   return Consumer<ClientsController>(
  //     builder: (context, clientsController, child) {
  //       // if (clientsController.isLoading) {
  //       //   return const Center(child: CircularProgressIndicator());
  //       // }
  //       List<DropdownMenuItem<String>> items = [];
  //       final invoiceType = context.read<InvoiceController>().invoiceType;
  //
  //       // Determine whether to show cash clients or debt clients
  //       // if (clientsController.cashClients.isEmpty &&
  //       //     clientsController.debtClients.isEmpty) {
  //       //   items = [
  //       //     DropdownMenuItem(
  //       //       child: Text(AppLocalizations.of(context)!.no_clients),
  //       //     ),
  //       //   ];
  //       // } else if (invoiceType == 'cash') {
  //       //   items = clientsController.cashClients.map((client) {
  //       //     return DropdownMenuItem<String>(
  //       //       value: client.id.toString(),
  //       //       child: Text(client.tradeName ?? 'Unknown'),
  //       //     );
  //       //   }).toList();
  //       // } else if (invoiceType == 'debt') {
  //       //   items = clientsController.debtClients.map((client) {
  //       //     return DropdownMenuItem<String>(
  //       //       value: client.id.toString(),
  //       //       child: Text(client.tradeName ?? 'Unknown'),
  //       //     );
  //       //   }).toList();
  //       // }
  //
  //       // return InvoiceDropdown(
  //       //   title: "${AppLocalizations.of(context)!.client_name} *",
  //       //   items: items,
  //       //   hintText: clientsController.selectedClient ??
  //       //       AppLocalizations.of(context)!.select_client_name,
  //       //   value: clientsController.selectedClient,
  //       //   onChanged: clientsController.setSelectedClient,
  //       // );
  //     },
  //   );
  // }

  Widget _buildProductDropdown(BuildContext context) {
    LangController langController =
        Provider.of<LangController>(context, listen: false);
    return Consumer<ProductController>(
      builder: (context, productController, child) {
        if (productController.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return InvoiceRowWidget(
            widget: SizedBox(
              width: 220.w,
              height: 50.h,
              child: Semantics(
                label: AppLocalizations.of(context)!.select_product,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return AddItemSheet();
                      },
                    );
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "${AppLocalizations.of(context)!.select_product} +",
                      style: AppStyles.getFontStyle(
                        langController,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            title: AppLocalizations.of(context)!.products);
      },
    );
  }

  Widget _buildTaxField(BuildContext context) {
    return Selector<InvoiceController, TextEditingController?>(
      selector: (context, controller) => controller.taxTextEditingController,
      builder: (context, taxTextEditingController, child) {
        return InvoiceRowWidget(
          widget: SizedBox(
            width: 220.w,
            child: InputWidget(
              textEditingController: taxTextEditingController!,
              hintText: AppLocalizations.of(context)!.enter_tax,
              obscureText: false,
              backgroundColor: Colors.white,
              hintColor: Colors.black54,
              fontSize: 12.sp,
              keyboardType: TextInputType.number,
              suffixIcon: Icon(
                Icons.percent,
                size: 20.sp,
                color: Colors.black54,
              ),
            ),
          ),
          title: AppLocalizations.of(context)!.tax,
        );
      },
    );
  }

  Widget _buildDiscountField(BuildContext context) {
    return Selector<InvoiceController, TextEditingController?>(
      selector: (context, controller) =>
          controller.discountTextEditingController,
      builder: (context, discountTextEditingController, child) {
        return InvoiceRowWidget(
          widget: SizedBox(
            width: 220.w,
            child: InputWidget(
              textEditingController: discountTextEditingController!,
              hintText: AppLocalizations.of(context)!.enter_discount,
              obscureText: false,
              backgroundColor: Colors.white,
              hintColor: Colors.black54,
              fontSize: 12.sp,
              keyboardType: TextInputType.number,
              suffixIcon: Icon(
                Icons.discount_outlined,
                size: 20.sp,
                color: Colors.black54,
              ),
            ),
          ),
          title: AppLocalizations.of(context)!.discount,
        );
      },
    );
  }

  Widget _buildSubtotal(BuildContext context) {
    return InvoiceRowWidget(
      title: AppLocalizations.of(context)!.subtotal,
      widget: Container(
        width: 220.w,
        height: 50.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text("value"),
          ),
        ),
      ),
    );
  }

  Widget _buildTotal(BuildContext context) {
    return InvoiceRowWidget(
      title: AppLocalizations.of(context)!.total,
      widget: Container(
        width: 220.w,
        height: 50.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text("value"),
          ),
        ),
      ),
    );
  }

  Widget _buildStaticField({required String title, required String value}) {
    return InvoiceRowWidget(
      title: title,
      widget: Container(
        width: 220.w,
        height: 50.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(value),
          ),
        ),
      ),
    );
  }
}
