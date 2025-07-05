import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/controller/product_controller.dart';
import 'package:test_sales/model/product.dart';
import 'package:test_sales/view/widgets/main_widgets/main_appbar_widget.dart';
import '../../../../app_constants.dart';
import '../../../../controller/camera_controller.dart';
import '../../../../controller/lang_controller.dart';
import '../../../../controller/management_controller.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../widgets/main_widgets/custom_button_widget.dart';
import '../../../widgets/main_widgets/dialog_widget.dart';
import '../../../widgets/main_widgets/input_widget.dart';
import '../../../widgets/management_widgets/main/more_details_widget.dart';

class ProductMoreDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductMoreDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final langController = Provider.of<LangController>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppbarWidget(title: "${product.name} - ${local.details}"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Consumer<ProductController>(
          builder: (context, productCtrl, child) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  _buildProfileHeader(langController),
                  SizedBox(
                    height: 10.h,
                  ),
                  _buildProfileSection(context),
                  SizedBox(
                    height: 10.h,
                  ),
                  _buildPerformanceSection(context),
                  SizedBox(
                    height: 10.h,
                  ),
                  _buildDocumentsSection(context),
                  SizedBox(
                    height: 15.h,
                  ),
                  _buildButtonsRow(context),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfileHeader(LangController langController) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 120.h,
            width: 120.w,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(product.imageUrl),
                ),
                color: const Color(0xFFE7E7E7),
              ),
            ),
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    String formatDateWithTime(DateTime? dateTime) {
      if (dateTime == null) return "N/A";
      final formatter = DateFormat('yyyy-MM-dd | HH:mm');
      return formatter.format(dateTime);
    }

    final profileDetails = [
      {"label": local.product_name, "value": product.name},
      {"label": local.description, "value": product.description},
      {"label": local.brand, "value": product.brand},
      {"label": local.price, "value": "${product.price} JD"},
      {"label": local.quantity, "value": product.quantity.toString()},
      {"label": local.discount, "value": "${product.discount}%"},
      {"label": local.tax_rate, "value": "${product.taxRate}%"},
      {
        "label": local.is_available,
        "value": product.isAvailable ? local.yes : local.no
      },
      {
        "label": local.created_at,
        "value": formatDateWithTime(product.createdAt)
      },
      {
        "label": local.updated_at,
        "value": formatDateWithTime(product.updatedAt)
      },
    ];

    return MoreDetailsWidget(
      title: local.profile,
      leadingIcon: Icons.shopping_cart_outlined,
      expand: true,
      children: profileDetails.map((detail) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              InputWidget(
                textEditingController:
                    TextEditingController(text: detail['value']),
                label: detail['label'],
                readOnly: true,
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPerformanceSection(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    final performanceData = [
      {"label": local.total_sales, "value": "JD ${product.totalSales}"},
      {"label": local.units_sold, "value": "${product.unitsSold}"},
    ];

    return MoreDetailsWidget(
      title: local.performance,
      leadingIcon: Icons.assessment_outlined,
      children: performanceData.map((data) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              InputWidget(
                textEditingController:
                    TextEditingController(text: data['value']),
                label: data['label'],
                readOnly: true,
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDocumentsSection(BuildContext context) {
    final cameraCtrl = Provider.of<CameraController>(context);
    final local = AppLocalizations.of(context)!;

    List<String> productImages = cameraCtrl.getPhotosByType('product_images');

    return MoreDetailsWidget(
      title: local.documents_section,
      leadingIcon: Icons.attach_file,
      children: [
        if (productImages.isNotEmpty)
          Wrap(
            children: productImages.map((base64) {
              return Image.memory(base64Decode(base64));
            }).toList(),
          )
        else
          Text("local.no_photos_yet"),
      ],
    );
  }

  Widget _buildButtonsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Consumer<ManagementController>(
            builder: (context, managementController, child) {
              return CustomButtonWidget(
                title: AppLocalizations.of(context)!.update,
                color: AppConstants.primaryColor2,
                borderRadius: 12.r,
                titleColor: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                onPressed: () {},
              );
            },
          ),
        ),
        SizedBox(
          width: 20.h,
        ),
        Expanded(
          child: CustomButtonWidget(
            title: AppLocalizations.of(context)!.remove_product,
            color: Color(0xFF910000),
            borderRadius: 12.r,
            titleColor: Colors.white,
            fontSize: 15.sp,
            onPressed: () {
              _deleteCurrentUser(context);
            },
          ),
        )
      ],
    );
  }

  _deleteCurrentUser(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<ProductController>(
          builder: (context, productController, child) {
            return DialogWidget(
              title: AppLocalizations.of(context)!.confirm_deletion,
              content: AppLocalizations.of(context)!.remove_product,
              imageUrl: "assets/images/cancel.png",
              onPressed: () {
                productController.deleteProduct(product.id!);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            );
          },
        );
      },
    );
  }
}
