import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../app_constants.dart';
import '../../../../app_styles.dart';
import '../../../../controller/lang_controller.dart';

class MoreDetailsWidget extends StatelessWidget {
  final String title;
  final IconData? leadingIcon;
  final List<Widget> children;
  final Color? backgroundColor;
  final bool? expand;

  const MoreDetailsWidget(
      {super.key,
      required this.title,
      this.leadingIcon,
      required this.children,
      this.backgroundColor,
      this.expand});

  @override
  Widget build(BuildContext context) {
    final langController = Provider.of<LangController>(context, listen: false);

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        border: Border.all(color: AppConstants.buttonColor, width: 1.5.w),
      ),
      child: ExpansionTile(
        collapsedBackgroundColor: Colors.white,
        shape: Border.all(color: Colors.transparent, width: 0),
        title: Text(
          title,
          style: AppStyles.getFontStyle(
            langController,
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
        ),
        leading: Icon(leadingIcon),
        backgroundColor: Colors.white,
        initiallyExpanded: expand ?? false,
        iconColor: Colors.black,
        childrenPadding: EdgeInsets.symmetric(vertical: 10),
        children: children,
        onExpansionChanged: (value) {},
      ),
    );
  }
}
