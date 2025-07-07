import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../app_styles.dart';
import '../../../controller/lang_controller.dart';
import '../../../app_constants.dart';
import '../../../l10n/app_localizations.dart';
import 'card_widget.dart';

class MonthlySalesWidget extends StatelessWidget {
  final double currentSales;
  final double monthlyTarget;
  final VoidCallback? onTap;

  const MonthlySalesWidget({
    super.key,
    required this.currentSales,
    required this.monthlyTarget,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final langController = Provider.of<LangController>(context);
    final progress = monthlyTarget > 0 ? (currentSales / monthlyTarget) * 100 : 0.0;
    final isOverTarget = progress >= 100;

    String getMonthName(LangController langCtrl) {
      final now = DateTime.now();
      final format = langCtrl.locale == 'ar' ? 'MMMM yyyy' : 'MMM yyyy';
      return DateFormat(format).format(now);
    }

    final monthName = getMonthName(langController);

    return CardWidget(
      title: local.monthly_sales,
      date: monthName,
      textColor: Colors.black,
      cardColor: const Color(0xFFEBF1FD),
      langController: langController,
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "${currentSales.toStringAsFixed(2)} JD",
              style: AppStyles.getFontStyle(
                langController,
                color: AppConstants.primaryColor2,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 30.h),
          LinearProgressIndicator(
            value: progress.clamp(0.0, 100.0) / 100,
            backgroundColor: Colors.grey[300],
            color: isOverTarget ? Colors.green : const Color(0xFF0B2B4A),
            borderRadius: BorderRadius.circular(20.r),
          ),
          SizedBox(height: 8.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '${progress.toStringAsFixed(1)}%',
              style: TextStyle(
                color: isOverTarget ? Colors.green : const Color(0xFF0B2B4A),
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}