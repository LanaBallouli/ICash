import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/controller/lang_controller.dart';
import 'package:test_sales/view/widgets/invoice_row_widget.dart';

import '../../app_styles.dart';

class InvoiceDropdown extends StatelessWidget {
  final String title;
  final List<DropdownMenuItem<String>> items;
  final String? value;
  final Function(String?) onChanged;
  final String? hintText;
  final double? width;
  final Color? color;
  final Color? dropdownColor;

  const InvoiceDropdown({
    super.key,
    required this.title,
    required this.items,
    required this.hintText,
    required this.value,
    this.width,
    this.dropdownColor,
    required this.onChanged,
    this.color = const Color(0xFFECF0F6),
  });

  @override
  Widget build(BuildContext context) {
    LangController langController =
        Provider.of<LangController>(context, listen: false);
    return InvoiceRowWidget(
      widget: Container(
        width: 220.w,
        height: 50.h,
        padding: EdgeInsets.only(left: 24.w, right: 24.w),
        decoration: BoxDecoration(
          color: dropdownColor ?? Colors.white,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: .3,
              offset: Offset(0, 1.5),
            ),
          ],
        ),
        child: DropdownButton<String>(
          alignment: Alignment.centerRight,
          dropdownColor: Color(0xFFEBF1FD),
          borderRadius: BorderRadius.circular(20.w),
          style: AppStyles.getFontStyle(
            langController,
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
          hint: SizedBox(
            child: Row(
              children: [
                Text(
                  value ?? hintText!,
                  style: AppStyles.getFontStyle(
                    langController,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(width: 8.w),
                // Icon(
                //   icon,
                //   size: 15.sp,
                // ),
              ],
            ),
          ),
          value: value,
          items: items,
          onChanged: onChanged,
        ),
      ),
      title: title,
      color: color,
    );
  }
}
