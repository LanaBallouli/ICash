import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/controller/clients_controller.dart';
import 'package:test_sales/controller/lang_controller.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import 'package:test_sales/model/client.dart';
import 'package:test_sales/view/screens/management_screens/client/client_more_details_screen.dart';
import 'package:test_sales/view/widgets/main_widgets/custom_button_widget.dart';
import '../../../../app_constants.dart';

class ClientsWidget extends StatelessWidget {
  final Client client;
  final int index;

  const ClientsWidget({super.key, required this.client, required this.index});

  @override
  Widget build(BuildContext context) {
    String formatDateWithTime(DateTime dateTime) {
      final formatter = DateFormat('yyyy-MM-dd');
      return formatter.format(dateTime);
    }

    final langController = Provider.of<LangController>(context, listen: false);
    final region = Provider.of<ClientsController>(context, listen: false)
        .getRegionName(client.regionId, context);

    return Row(
      children: [
        Container(
          height: 120.h,
          width: 10.w,
          decoration: BoxDecoration(
            color: AppConstants.primaryColor2,
            borderRadius: _getBorderRadiusBasedOnLanguage(
              context,
              false,
            ),
            border: Border.all(color: AppConstants.primaryColor2, width: 1.5.w),
          ),
        ),
        Expanded(
          child: Container(
            height: 120.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: _getBorderRadiusBasedOnLanguage(
                context,
                true,
              ),
              border: Border.all(color: AppConstants.buttonColor, width: 1.5.w),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow(
                        context,
                        AppLocalizations.of(context)!.name,
                        client.tradeName ?? "N/A",
                        langController,
                      ),
                      _buildDetailRow(
                        context,
                        AppLocalizations.of(context)!.region,
                        region ?? "N/A",
                        langController,
                      ),
                      // _buildDetailRow(
                      //   context,
                      //   AppLocalizations.of(context)!.region,
                      //   client ?? "N/A",
                      //   langController,
                      // ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: CustomButtonWidget(
                      width: 90.w,
                      height: 45.h,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      title: AppLocalizations.of(context)!.more_details,
                      titleColor: Colors.white,
                      colors: [
                        AppConstants.primaryColor2,
                        AppConstants.primaryColor2
                      ],
                      borderRadius: 12.r,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClientMoreDetailsScreen(
                              client: client,
                              index: index,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value,
    LangController langController,
  ) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: SizedBox(
          width: 200.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$label:",
                style: AppStyles.getFontStyle(
                  langController,
                  fontSize: 14.sp,
                  color: Color(0xFF969AB0),
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                value,
                style: AppStyles.getFontStyle(
                  langController,
                  fontSize: 14.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BorderRadius _getBorderRadiusBasedOnLanguage(
    BuildContext context,
    bool isButton,
  ) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final rtlBorderRadius = BorderRadius.only(
      topRight: Radius.circular(12.r),
      bottomRight: Radius.circular(12.r),
    );
    final ltrBorderRadius = BorderRadius.only(
      topLeft: Radius.circular(12.r),
      bottomLeft: Radius.circular(12.r),
    );
    if (isArabic) {
      return isButton ? ltrBorderRadius : rtlBorderRadius;
    } else {
      return isButton ? rtlBorderRadius : ltrBorderRadius;
    }
  }
}
