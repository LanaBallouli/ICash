import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/controller/lang_controller.dart';
import 'package:test_sales/controller/sales_controller.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import 'package:test_sales/app_styles.dart';

import 'card_widget.dart';

class DailySalesWidget extends StatelessWidget {
  const DailySalesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final langCtrl = Provider.of<LangController>(context, listen: false);

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
                value: dailySales > 0 ? (dailySales / 100) : 0.0,
                backgroundColor: Colors.grey[300],
                color: dailySales >= 100 ? Colors.green : Colors.yellow,
                borderRadius: BorderRadius.circular(20.r),
              ),
              SizedBox(height: 8.h),
              Text(
                '${dailySales.toStringAsFixed(1)}%',
                style: TextStyle(
                  color: dailySales >= 100 ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<double> _fetchDailySales(BuildContext context) async {
    final local = AppLocalizations.of(context)!;
    final salesCtrl = context.read<SalesController>();

    try {
      final double dailySales = await salesCtrl.getDailySales(context);
      return dailySales;
    } catch (e) {
      print("Error fetching daily sales: $e");
      throw Exception(local.error_loading_data);
    }
  }
}