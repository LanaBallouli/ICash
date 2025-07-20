import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/controller/invoice_controller.dart';
import 'package:test_sales/controller/lang_controller.dart';
import 'package:test_sales/controller/product_controller.dart';
import 'package:test_sales/controller/clients_controller.dart';
import 'package:test_sales/view/widgets/main_widgets/custom_button_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/input_widget.dart';
import 'package:test_sales/model/product.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/app_constants.dart';
import 'package:test_sales/view/widgets/main_widgets/main_appbar_widget.dart';
import '../../widgets/management_widgets/client_widgets/build_client_dropdown.dart';

class CreateInvoiceScreen extends StatefulWidget {
  const CreateInvoiceScreen({super.key});

  @override
  State<CreateInvoiceScreen> createState() => _CreateInvoiceScreenState();
}

class _CreateInvoiceScreenState extends State<CreateInvoiceScreen> {
  late final InvoicesController invoiceController;
  late final ProductController productController;
  late final ClientsController clientsController;
  final TextEditingController _taxCtrl = TextEditingController(text: "0");
  String? _taxType = "exempt";
  final TextEditingController _discountCtrl = TextEditingController(text: "0");
  final TextEditingController _notesCtrl = TextEditingController();

  final DateTime _issueDate = DateTime.now();
  final List<Product> _selectedProducts = [];

  @override
  void initState() {
    productController = Provider.of<ProductController>(context, listen: false);
    clientsController = Provider.of<ClientsController>(context, listen: false);
    invoiceController = Provider.of<InvoicesController>(context, listen: false);

    super.initState();

    if (productController.products.isEmpty) {
      productController.fetchAllProducts();
    }

    if (clientsController.clients.isEmpty) {
      clientsController.fetchAllClients();
    }
  }

  @override
  Widget build(BuildContext context) {
    final langController = Provider.of<LangController>(context, listen: false);
    final invoiceCtrl = Provider.of<InvoicesController>(context, listen: false);
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppbarWidget(title: local.create_invoice),
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(local.select_client,
                  style: AppStyles.getFontStyle(langController)),
              SizedBox(height: 8.h),
              Consumer<InvoicesController>(
                builder: (context, invoicesController, child) {
                  return buildClientDropdown(
                    context,
                    invoicesController.selectedClient,
                    (value) {
                      invoiceCtrl.setSelectedClient(value!);
                    },
                  );
                },
              ),
              SizedBox(height: 6.h),
              Divider(
                color: AppConstants.buttonColor,
              ),
              SizedBox(height: 6.h),
              Text(local.select_products,
                  style: AppStyles.getFontStyle(langController)),
              SizedBox(height: 8.h),
              ...productController.products.map(
                (product) {
                  bool isSelected = _selectedProducts.contains(product);
                  return ListTile(
                    title: Text("${product.name} - ${product.price} JD"),
                    trailing: isSelected
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  setState(() {
                                    _selectedProducts.remove(product);
                                  });
                                },
                              ),
                              Text("1"),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    _selectedProducts.add(product);
                                  });
                                },
                              ),
                            ],
                          )
                        : ElevatedButton.icon(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                AppConstants.buttonColor,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _selectedProducts.add(product);
                              });
                            },
                            icon: Icon(
                              Icons.add,
                              color: AppConstants.primaryColor2,
                            ),
                            label: Text(
                              local.select,
                              style: AppStyles.getFontStyle(langController,
                                  color: AppConstants.primaryColor2),
                            ),
                          ),
                  );
                },
              ),
              Divider(
                color: AppConstants.buttonColor,
              ),
              SizedBox(height: 10.h),
              Text(
                local.tax_type,
                style: AppStyles.getFontStyle(langController),
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Radio<String>(
                        value: "exempt",
                        groupValue: _taxType,
                        onChanged: (value) {
                          setState(() {
                            _taxType = value;
                            _taxCtrl.text = "0";
                          });
                        },
                        activeColor: AppConstants.primaryColor2,
                      ),
                      Text(
                        local.exempt,
                        style: AppStyles.getFontStyle(
                          langController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 20.w),
                  Row(
                    children: [
                      Radio<String>(
                        value: "inclusive",
                        groupValue: _taxType,
                        onChanged: (value) {
                          setState(() {
                            _taxType = value;
                            _taxCtrl.text = "1.16";
                          });
                        },
                        activeColor: AppConstants.primaryColor2,
                      ),
                      Text(
                        local.inclusive,
                        style: AppStyles.getFontStyle(langController),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                local.issue_date,
                style: AppStyles.getFontStyle(langController),
              ),
              SizedBox(height: 8.h),
              InputWidget(
                textEditingController: TextEditingController(
                    text: DateFormat('yyyy-MM-dd').format(_issueDate)),
                readOnly: true,
              ),
              SizedBox(height: 12.h),
              Text(
                local.notes,
                style: AppStyles.getFontStyle(langController),
              ),
              SizedBox(height: 8.h),
              InputWidget(
                textEditingController: _notesCtrl,
                maxLines: 3,
                keyboardType: TextInputType.text,
                onChanged: (value) {},
              ),
              SizedBox(height: 20.h),
              Text(
                local.summary,
                style: AppStyles.getFontStyle(langController),
              ),
              SizedBox(height: 8.h),
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 4.r,
                  color: AppConstants.buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      12.r,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${local.subtotal}: ${_calculateTotal().toStringAsFixed(2)} JD",
                          style: AppStyles.getFontStyle(
                            langController,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        if (_taxType != "exempt") ...[
                          Text(
                            "${local.tax}: ${_getTaxAmount().toStringAsFixed(2)} JD",
                            style: AppStyles.getFontStyle(
                              langController,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                        SizedBox(
                          height: 12.h,
                        ),
                        Divider(
                          color: Colors.grey[300],
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Text(
                          "${local.final_total}: ${_calculateFinalTotal().toStringAsFixed(2)} JD",
                          style: AppStyles.getFontStyle(
                            langController,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              CustomButtonWidget(
                title: local.save,
                color: AppConstants.primaryColor2,
                titleColor: Colors.white,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _getTaxAmount() {
    final subtotal = _calculateTotal();
    final discount = double.tryParse(_discountCtrl.text) ?? 0.0;

    final subtotalAfterDiscount = subtotal - discount;

    if (_taxType == "inclusive") {
      return subtotalAfterDiscount * 0.16;
    }

    return 0.0;
  }

  double _calculateTotal() {
    return _selectedProducts.map((p) => p.price).sum;
  }

  double _calculateFinalTotal() {
    final subtotal = _calculateTotal();
    final discount = double.tryParse(_discountCtrl.text) ?? 0.0;

    final subtotalAfterDiscount = subtotal - discount;

    if (_taxType == "inclusive") {
      return subtotalAfterDiscount * 1.16;
    }

    return subtotalAfterDiscount;
  }
}
