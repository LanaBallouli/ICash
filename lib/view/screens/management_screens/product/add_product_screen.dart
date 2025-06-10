import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_constants.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/controller/product_controller.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import 'package:test_sales/model/product.dart';
import 'package:test_sales/view/widgets/main_widgets/custom_button_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/input_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/main_appbar_widget.dart';

import '../../../../controller/lang_controller.dart';
import '../../../widgets/main_widgets/dialog_widget.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late ProductController productController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    productController = Provider.of<ProductController>(context, listen: false);
  }

  Future<void> _saveProduct(BuildContext context) async {
    final local = AppLocalizations.of(context)!;

    await productController.addNewProduct(
      Product(
        name: productController.nameController.text,
        description: productController.descriptionController.text,
        price: double.tryParse(productController.priceController.text) ?? 0.0,
        brand: productController.brandController.text,
        quantity: int.tryParse(productController.quantityController.text) ?? 0,
        isAvailable: productController.isAvailable,
        discount:
            double.tryParse(productController.discountController.text) ?? 0.0,
        taxRate:
            double.tryParse(productController.taxRateController.text) ?? 0.0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        imageUrl: "assets/images/default_image.png",
      ),
    );

    if (productController.errorMessage.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(productController.errorMessage)),
      );
      return;
    }

    // Show success dialog
    await showDialog(
      context: context,
      builder: (_) => DialogWidget(
        title: "local.product_added",
        content: "local.product_added_successfully",
        imageUrl: "assets/images/success.png",
        actions: [
          CustomButtonWidget(
            title: local.ok,
            onPressed: Navigator.of(context).pop,
            colors: [AppConstants.primaryColor2, AppConstants.primaryColor2],
            borderRadius: 12.r,
          ),
        ],
      ),
    );

    // Go back and clear fields
    Navigator.pop(context);
    productController.clearErrors();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final langController = Provider.of<LangController>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppbarWidget(title: local.add_product),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  local.add_product_prompt,
                  style: AppStyles.getFontStyle(
                    langController,
                    color: Colors.black54,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              InputWidget(
                textEditingController: productController.nameController,
                label: local.product_name,
                hintText: local.enter_product_name,
              ),
              SizedBox(height: 15.h),
              InputWidget(
                textEditingController: productController.descriptionController,
                label: local.description,
                hintText: local.enter_description,
                maxLines: 3,
              ),
              SizedBox(height: 15.h),
              InputWidget(
                textEditingController: productController.priceController,
                label: local.price,
                hintText: local.enter_price,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 15.h),
              InputWidget(
                textEditingController: productController.brandController,
                label: local.brand,
                hintText: local.enter_brand,
              ),
              SizedBox(height: 15.h),
              InputWidget(
                textEditingController: productController.quantityController,
                label: local.quantity,
                hintText: local.enter_quantity,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 15.h),
              InputWidget(
                textEditingController: productController.discountController,
                label: local.discount,
                hintText: local.enter_discount,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 15.h),
              InputWidget(
                textEditingController: productController.taxRateController,
                label: local.tax_rate,
                hintText: local.enter_tax_rate,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(local.is_available),
                  Switch(
                    value: productController.isAvailable,
                    onChanged: (value) {
                      productController.isAvailable = value;
                    },
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Row(
                children: [
                  Expanded(
                    child: CustomButtonWidget(
                      title: local.save,
                      colors: [
                        AppConstants.primaryColor2,
                        AppConstants.primaryColor2
                      ],
                      borderRadius: 12.r,
                      titleColor: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      onPressed: () => _saveProduct(context),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: CustomButtonWidget(
                      title: local.cancel,
                      colors: [
                        AppConstants.buttonColor,
                        AppConstants.buttonColor
                      ],
                      borderRadius: 12.r,
                      titleColor: Colors.grey,
                      fontSize: 15.sp,
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
