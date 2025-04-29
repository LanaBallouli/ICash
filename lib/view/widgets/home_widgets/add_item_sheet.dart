import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/controller/lang_controller.dart';
import 'package:test_sales/controller/product_controller.dart';
import 'package:test_sales/view/widgets/main_widgets/incremental_button.dart';
import 'package:test_sales/view/widgets/home_widgets/invoice_drop_down.dart';
import 'package:test_sales/view/widgets/home_widgets/invoice_row_widget.dart';
import '../../../app_styles.dart';
import '../../../l10n/app_localizations.dart';

class AddItemSheet extends StatelessWidget {
  const AddItemSheet({super.key});

  @override
  Widget build(BuildContext context) {
    LangController langController =
        Provider.of<LangController>(context, listen: false);
    // return Padding(
    //   padding: EdgeInsets.only(
    //     bottom:
    //         MediaQuery.of(context).viewInsets.bottom, // Handle keyboard overlap
    //   ),
    //   child:
    return Container(
      width: double.infinity,
      height: 500,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFECF0F6),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  AppLocalizations.of(context)!.add_item,
                  style: AppStyles.getFontStyle(
                    langController,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 20.sp,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
                child: Text(
                  AppLocalizations.of(context)!.add_item_prompt,
                  style: AppStyles.getFontStyle(
                    langController,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: Colors.black38,
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Consumer<ProductController>(
                builder: (context, productController, child) {
                  return InvoiceDropdown(
                    dropdownColor: Color(0xFFECF0F6),
                    color: Colors.white,
                    title: AppLocalizations.of(context)!.item,
                    items: productController.products.isEmpty
                        ? [
                            DropdownMenuItem<String>(
                              value: null,
                              child: Text(
                                AppLocalizations.of(context)!.no_products,
                              ),
                            ),
                          ]
                        : productController.products.map((product) {
                            return DropdownMenuItem<String>(
                              value: product.id.toString(),
                              child: Text(product.name ?? 'Unknown'),
                            );
                          }).toList(),
                    hintText: productController.selectedProduct ??
                        AppLocalizations.of(context)!.select_product,
                    value: productController.selectedProduct,
                    onChanged: (String? value) {
                      productController.setSelectedProduct(value);
                    },
                  );
                },
              ),
              SizedBox(
                height: 15.h,
              ),
              Consumer<ProductController>(
                builder: (context, productController, child) {
                  final selectedProduct =
                      productController.selectedProductDetails;
                  final unitPrice = selectedProduct?.price?.toString() ?? "N/A";
                  return _buildStaticField(
                    title: AppLocalizations.of(context)!.unit_price,
                    value: unitPrice,
                  );
                },
              ),
              SizedBox(
                height: 15.h,
              ),
              Consumer<ProductController>(
                builder: (context, productController, child) {
                  return InvoiceRowWidget(
                    color: Colors.white,
                    widget: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFECF0F6),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      width: 220.w,
                      child: IncrementalButton(
                        value: productController.itemAmount,
                        onIncrement: () =>
                            productController.incrementItemAmount(),
                        onDecrement: () =>
                            productController.decrementItemAmount(),
                      ),
                    ),
                    title: AppLocalizations.of(context)!.amount,
                  );
                },
              ),
              SizedBox(
                height: 15.h,
              ),
              Consumer<ProductController>(
                builder: (context, productController, child) {
                  return _buildStaticField(
                    title: AppLocalizations.of(context)!.subtotal,
                    value: productController.subTotal.toString(),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStaticField({required String title, required String value}) {
    return InvoiceRowWidget(
      color: Colors.white,
      title: title,
      widget: Container(
        width: 220.w,
        height: 50.h,
        decoration: BoxDecoration(
          color: Color(0xFFECF0F6),
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
