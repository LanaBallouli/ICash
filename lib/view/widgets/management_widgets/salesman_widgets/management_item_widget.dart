import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/controller/lang_controller.dart';
import 'package:test_sales/model/product.dart';
import 'package:test_sales/model/salesman.dart';
import 'package:test_sales/view/screens/management_screens/product/product_more_details_screen.dart';
import 'package:test_sales/view/screens/management_screens/salesmen_screens/salesmen_more_details_screen.dart';
import '../../../../app_constants.dart';
import '../../../../controller/salesman_controller.dart';
import '../../../../l10n/app_localizations.dart';
import '../../main_widgets/custom_button_widget.dart';

class ManagementItemWidget<T> extends StatelessWidget {
  final bool isProduct;
  final T item;
  final int index;

  const ManagementItemWidget({
    super.key,
    required this.item,
    required this.index,
    this.isProduct = false,
  });

  @override
  Widget build(BuildContext context) {
    final langController = Provider.of<LangController>(context, listen: false);

    return SizedBox(
      height: 300.h,
      width: 177.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 240.h,
            width: 174.w,
            decoration: BoxDecoration(
              border: Border.all(color: AppConstants.buttonColor, width: 1.5.w),
              borderRadius: BorderRadius.circular(25.r),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 70.h),
                  Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      _getTitle(context),
                      style: GoogleFonts.sora(
                        color: const Color(0xFF24262F),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _getRegionLabel(context),
                          style: AppStyles.getFontStyle(
                            langController,
                            fontSize: 10.sp,
                            color: const Color(0xFF969AB0),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          _getRegionValue(context),
                          style: AppStyles.getFontStyle(
                            langController,
                            fontSize: 10.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  if (_showClosedDeals())
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${AppLocalizations.of(context)!.closed_deals}:",
                            style: AppStyles.getFontStyle(
                              langController,
                              fontSize: 10.sp,
                              color: const Color(0xFF969AB0),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            _getClosedDeals(context),
                            style: AppStyles.getFontStyle(
                              langController,
                              fontSize: 10.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: _showClosedDeals() ? 12.h : 0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _getTotalSalesLabel(context),
                          style: AppStyles.getFontStyle(
                            langController,
                            fontSize: 10.sp,
                            color: const Color(0xFF969AB0),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          _getTotalSales(context),
                          style: AppStyles.getFontStyle(
                            langController,
                            fontSize: 10.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: SizedBox(
              height: 89.h,
              width: 89.w,
              child: CircleAvatar(
                backgroundColor: const Color(0xFFE7E7E7),
                foregroundImage: AssetImage(_getImagePath(context)),
              ),
            ),
          ),
          if (!_isProduct())
            Positioned(
              right: 0,
              top: 20,
              child: Container(
                height: 36.h,
                width: 36.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.r),
                  color: AppConstants.buttonColor,
                ),
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      if (!_isProduct()) {
                        final salesman = item as SalesMan;
                        final controller = Provider.of<SalesmanController>(
                            context,
                            listen: false);
                        controller.toggleFavourite(salesman);
                      }
                    },
                    icon: _isProduct()
                        ? const Icon(Icons.add_shopping_cart)
                        : Provider.of<SalesmanController>(context)
                                .isFavourite(item as SalesMan)
                            ? Icon(
                                Icons.favorite,
                                color: AppConstants.errorColor,
                                size: 17.w,
                              )
                            : Icon(
                                Icons.favorite_border,
                                color: const Color(0xFF222628),
                                size: 17.w,
                              ),
                  ),
                ),
              ),
            ),
          Positioned(
            bottom: 25,
            left: 20,
            right: 20,
            child: CustomButtonWidget(
              width: 110.w,
              height: 45.h,
              title: AppLocalizations.of(context)!.more_details,
              titleColor: Colors.white,
              color: AppConstants.primaryColor2,
              borderRadius: 25.r,
              onPressed: () {
                if (_isProduct()) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductMoreDetailsScreen(
                          product: item as Product,
                        ),
                      ));
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SalesmenMoreDetailsScreen(
                        users: item as SalesMan,
                        index: index,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  bool _isProduct() => isProduct;

  String _getTitle(BuildContext context) {
    if (_isProduct()) {
      final product = item as Product;
      return product.name;
    } else {
      final salesman = item as SalesMan;
      return salesman.fullName;
    }
  }

  String _getRegionLabel(BuildContext context) {
    return "${AppLocalizations.of(context)!.region}:";
  }

  String _getRegionValue(BuildContext context) {
    if (_isProduct()) return "N/A";
    final salesman = item as SalesMan;
    final region = Provider.of<SalesmanController>(context, listen: false)
        .getRegionName(salesman.regionId, context);
    return region;
  }

  String _getClosedDeals(BuildContext context) {
    if (_isProduct()) return "N/A";
    final salesman = item as SalesMan;
    return salesman.closedDeals.toString();
  }

  bool _showClosedDeals() {
    return !_isProduct();
  }

  String _getTotalSalesLabel(BuildContext context) {
    return _isProduct()
        ? "${AppLocalizations.of(context)!.price}:"
        : "${AppLocalizations.of(context)!.total_sales}:";
  }

  String _getTotalSales(BuildContext context) {
    if (_isProduct()) {
      final product = item as Product;
      return "${product.price.toStringAsFixed(2)} JD";
    } else {
      final salesman = item as SalesMan;
      return "${salesman.totalSales.toStringAsFixed(2)} JD";
    }
  }

  String _getImagePath(BuildContext context) {
    if (_isProduct()) {
      final product = item as Product;
      return product.imageUrl ?? "assets/images/default_product.png";
    } else {
      final salesman = item as SalesMan;
      return salesman.imageUrl ?? "assets/images/default_image.png";
    }
  }
}
