import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/controller/lang_controller.dart';
import '../../main_widgets/input_widget.dart';

class ManagementInputWidget extends StatelessWidget {
  final String? hintText;
  final String title;
  final TextEditingController controller;
  final dynamic Function(String)? onChanged;
  final String? errorText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final bool? obscureText;
  final double? height;
  final int? maxLines;
  final FocusNode? focusNode;

  const ManagementInputWidget(
      {super.key,
      required this.hintText,
      this.errorText,
      this.onChanged,
      required this.controller,
      required this.title,
      required this.keyboardType,
      this.suffixIcon,
      this.obscureText,
      this.height,
      this.maxLines,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    final langController = Provider.of<LangController>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyles.getFontStyle(
              langController,
              color: Color(0xFF6C7278),
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          InputWidget(
            focusNode: focusNode,
            height: height,
            textEditingController: controller,
            obscureText: obscureText ?? false,
            keyboardType: keyboardType,
            suffixIcon: suffixIcon,
            labelColor: Colors.grey,
            hintText: hintText,
            onChanged: onChanged,
            errorText: errorText,
            maxLines: maxLines,
          ),
        ],
      ),
    );
  }
}
