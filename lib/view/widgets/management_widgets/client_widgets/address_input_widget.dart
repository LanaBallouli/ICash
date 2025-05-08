import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../app_styles.dart';
import '../../../../controller/lang_controller.dart';
import '../../main_widgets/input_widget.dart';

class AddressInputWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String title;
  final TextInputType? keyboardType;
  final dynamic Function(String)? onChanged;
  final String? errorText;

  const AddressInputWidget(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.title,
      required this.keyboardType,
      this.onChanged,
      this.errorText});

  @override
  Widget build(BuildContext context) {
    final langController = Provider.of<LangController>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
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
            borderColor: Color(0xFFEFF0F6),
            textEditingController: controller,
            obscureText: false,
            maxLines: 3,
            keyboardType: keyboardType,
            hintText: hintText,
            onChanged: onChanged,
            errorText: errorText,
          ),
        ],
      ),
    );
  }
}
