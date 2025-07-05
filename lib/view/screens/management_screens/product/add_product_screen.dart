import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_constants.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/controller/product_controller.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import 'package:test_sales/model/product.dart';
import 'package:test_sales/view/widgets/main_widgets/custom_button_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/main_appbar_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/salesman_widgets/management_input_widget.dart';
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
    productController = Provider.of<ProductController>(context);
  }

  Future<void> _saveProduct(BuildContext context) async {
    final local = AppLocalizations.of(context)!;

    productController.validateForm(context: context);

    if (!productController.isFormValid()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(local.fill_all_fields)),
      );
      return;
    }

    try {
      await productController.addNewProduct(
        Product(
          name: productController.nameController.text,
          description: productController.descriptionController.text,
          price: double.parse(productController.priceController.text),
          brand: productController.brandController.text,
          quantity: int.parse(productController.quantityController.text),
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

      await showDialog(
        context: context,
        builder: (_) => DialogWidget(
          title: local.product_added,
          content: local.product_added_successfully,
          imageUrl: "assets/images/success.png",
          actions: [
            CustomButtonWidget(
              title: local.ok,
              onPressed: Navigator.of(context).pop,
              color: AppConstants.primaryColor2,
              borderRadius: 12.r,
            ),
          ],
        ),
      );

      Navigator.pop(context);
      productController.clearErrors();
    } catch (e) {
      print("Error adding product: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(local.something_went_wrong)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final langController = Provider.of<LangController>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppbarWidget(
        title: local.add_product,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            productController.clearErrors();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
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
              ManagementInputWidget(
                hintText: local.enter_product_name,
                controller: productController.nameController,
                title: local.product_name,
                keyboardType: TextInputType.text,
                errorText: productController.errors['name'],
                onChanged: (value) => productController.validateName(local),
              ),
              ManagementInputWidget(
                hintText: local.enter_description,
                controller: productController.descriptionController,
                title: local.description,
                keyboardType: TextInputType.text,
                errorText: productController.errors['description'],
                onChanged: (value) =>
                    productController.validateDescription(local),
                maxLines: 3,
                height: 120.h,
              ),
              ManagementInputWidget(
                hintText: local.enter_price,
                controller: productController.priceController,
                title: local.price,
                keyboardType: TextInputType.number,
                errorText: productController.errors['price'],
                onChanged: (value) => productController.validatePrice(local),
              ),
              ManagementInputWidget(
                hintText: local.enter_brand,
                controller: productController.brandController,
                title: local.brand,
                keyboardType: TextInputType.text,
                errorText: productController.errors['brand'],
                onChanged: (value) => productController.validateBrand(local),
              ),
              ManagementInputWidget(
                hintText: local.enter_quantity,
                controller: productController.quantityController,
                title: local.quantity,
                keyboardType: TextInputType.number,
                errorText: productController.errors['quantity'],
                onChanged: (value) => productController.validateQuantity(local),
              ),
              ManagementInputWidget(
                hintText: local.enter_discount,
                controller: productController.discountController,
                title: local.discount,
                keyboardType: TextInputType.number,
                errorText: productController.errors['discount'],
                onChanged: (value) => productController.validateDiscount(local),
              ),
              ManagementInputWidget(
                hintText: local.enter_tax_rate,
                controller: productController.taxRateController,
                title: local.tax_rate,
                keyboardType: TextInputType.number,
                errorText: productController.errors['tax_rate'],
                onChanged: (value) => productController.validateTaxRate(local),
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    local.is_available,
                    style:
                        AppStyles.getFontStyle(langController, fontSize: 14.sp),
                  ),
                  Consumer<ProductController>(
                    builder: (context, productController, child) {
                      return Switch(
                        value: productController.isAvailable,
                        activeTrackColor: AppConstants.primaryColor2,
                        inactiveTrackColor: Colors.grey[200],
                        onChanged: (value) {
                          productController.toggleAvailableProduct();
                        },
                      );
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
                      color: AppConstants.primaryColor2,
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
                      color: AppConstants.buttonColor,
                      borderRadius: 12.r,
                      titleColor: Colors.grey,
                      fontSize: 15.sp,
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        productController.clearErrors();
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
