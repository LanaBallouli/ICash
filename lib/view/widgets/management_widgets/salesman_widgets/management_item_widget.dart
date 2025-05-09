import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/controller/lang_controller.dart';
import 'package:test_sales/controller/management_controller.dart';
import 'package:test_sales/model/users.dart';
import 'package:test_sales/view/screens/management_screens/salesmen_screens/salesmen_more_details_screen.dart';
import '../../../../app_constants.dart';
import '../../../../l10n/app_localizations.dart';
import '../../main_widgets/custom_button_widget.dart';

class ManagementItemWidget extends StatelessWidget {
  final Users users;
  final int index;

  const ManagementItemWidget(
      {super.key, required this.users, required this.index});

  @override
  Widget build(BuildContext context) {
    final langController = Provider.of<LangController>(context, listen: false);
    return Consumer<ManagementController>(
      builder: (context, managementController, child) {
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
                  border:
                      Border.all(color: AppConstants.buttonColor, width: 1.5.w),
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
                          users.fullName ?? "name",
                          style: GoogleFonts.sora(
                            color: Color(0xFF24262F),
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
                              "${AppLocalizations.of(context)!.region}:",
                              style: AppStyles.getFontStyle(
                                langController,
                                fontSize: 10.sp,
                                color: Color(0xFF969AB0),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              users.region?.name ?? "region",
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
                                color: Color(0xFF969AB0),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              users.closedDeals.toString() ?? "0",
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
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${AppLocalizations.of(context)!.total_sales}:",
                              style: AppStyles.getFontStyle(
                                langController,
                                fontSize: 10.sp,
                                color: Color(0xFF969AB0),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              users.totalSales.toString() ?? "totalSales",
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
                    backgroundColor: Color(0xFFE7E7E7),
                    foregroundImage: AssetImage(
                        users.imageUrl ?? "assets/images/default_image.png"),
                  ),
                ),
              ),

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
                        managementController.toggleFavourite(context, users);
                      },
                      icon: managementController.isFavourite(users)
                          ? Icon(
                              Icons.favorite,
                              color: AppConstants.errorColor,
                              size: 17.w,
                            )
                          : Icon(
                              Icons.favorite_border,
                              color: Color(0xFF222628),
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
                  colors: [
                    AppConstants.primaryColor2,
                    AppConstants.primaryColor2
                  ],
                  borderRadius: 25.r,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SalesmenMoreDetailsScreen(
                          users: users,
                          index: index,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
