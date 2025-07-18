import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/controller/lang_controller.dart';
import 'package:test_sales/controller/sales_controller.dart';
import 'package:test_sales/controller/management_controller.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import 'package:test_sales/app_styles.dart';
import 'card_widget.dart';

class DailySalesWidget extends StatelessWidget {
  const DailySalesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final langCtrl = Provider.of<LangController>(context, listen: false);

    return Consumer2<SalesController, ManagementController>(
      builder: (context, salesCtrl, managementCtrl, _) {
        return FutureBuilder<double>(
          future: _fetchDailySales(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CardWidget(
                title: local.daily_sales,
                date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                textColor: Colors.black,
                cardColor: const Color(0xFF10376A),
                langController: langCtrl,
                widget: Center(child: CircularProgressIndicator()),
              );
            }

            if (snapshot.hasError) {
              return CardWidget(
                title: local.daily_sales,
                date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                textColor: Colors.black,
                cardColor: const Color(0xFF10376A),
                langController: langCtrl,
                widget: Center(
                  child: Text(
                    "${local.error_loading_data}: ${snapshot.error}",
                    style: AppStyles.getFontStyle(langCtrl, color: Colors.red),
                  ),
                ),
              );
            }

            final dailySales = snapshot.data ?? 0.0;
            final dailyTarget = managementCtrl.dailyTarget;

            double progressPercent = 0.0;
            if (dailyTarget > 0) {
              progressPercent = (dailySales / dailyTarget) * 100;
            }

            bool isTargetMet = progressPercent >= 100;

            return CardWidget(
              title: local.daily_sales,
              date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
              textColor: Colors.white,
              cardColor: const Color(0xFF10376A),
              langController: langCtrl,
              widget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "${dailySales.toStringAsFixed(2)} JD",
                      style: AppStyles.getFontStyle(
                        langCtrl,
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    local.progress,
                    style: AppStyles.getFontStyle(
                      langCtrl,
                      color: Colors.grey.shade300,
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  LinearProgressIndicator(
                    value: (progressPercent.clamp(0.0, 100.0)) / 100,
                    backgroundColor: Colors.grey[300],
                    color: isTargetMet ? Colors.green : Colors.yellow,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '${progressPercent.toStringAsFixed(1)}%',
                    style: TextStyle(
                      color: isTargetMet ? Colors.green : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "$local.target: ${dailyTarget.toStringAsFixed(2)} JD",
                    style: AppStyles.getFontStyle(langCtrl, fontSize: 12.sp, color: Colors.white70),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<double> _fetchDailySales(BuildContext context) async {
    final local = AppLocalizations.of(context)!;
    final salesCtrl = context.read<SalesController>();

    try {
      final dailySales = await salesCtrl.getDailySales(context);
      print("✅ Daily Sales Fetched: $dailySales");
      return dailySales;
    } catch (e, stackTrace) {
      print("❌ Error fetching daily sales: $e");
      print("Stack Trace: $stackTrace");
      throw Exception(local.error_loading_data);
    }
  }
}