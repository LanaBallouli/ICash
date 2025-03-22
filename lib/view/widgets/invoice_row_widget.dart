import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/controller/lang_controller.dart';

import '../../app_styles.dart';

class InvoiceRowWidget extends StatelessWidget {
  final String title;
  final Widget widget;
  final Color? color;

  const InvoiceRowWidget(
      {super.key, required this.widget, required this.title, this.color = const Color(0xFFECF0F6)});

  @override
  Widget build(BuildContext context) {
    LangController langController =
        Provider.of<LangController>(context, listen: false);
    return Container(
      height: 70.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: color,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            Text(
              title,
              style: AppStyles.getFontStyle(
                langController,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            Spacer(),
            widget,
          ],
        ),
      ),
    );
  }
}
