import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_constants.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/controller/management_controller.dart';
import '../../../controller/lang_controller.dart';
import '../../../l10n/app_localizations.dart';

class CategoryButtonsWidget extends StatelessWidget {
  const CategoryButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ManagementController>(
      builder: (context, controller, child) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildButton(
                context,
                AppLocalizations.of(context)!.sales_men,
                0,
                Icons.people_alt_outlined,
                controller,
              ),
              SizedBox(width: 12.w,),
              _buildButton(
                context,
                AppLocalizations.of(context)!.clients,
                1,
                Icons.groups_2,
                controller,
              ),
              SizedBox(width: 12.w,),
              _buildButton(
                context,
                AppLocalizations.of(context)!.products,
                2,
                Icons.shopping_cart_outlined,
                controller,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildButton(
    BuildContext context,
    String label,
    int index,
    IconData icon,
    ManagementController controller,
  ) {
    bool isSelected = controller.selectedIndex == index;
    final langController = Provider.of<LangController>(context);
    return InkWell(
      onTap: () {
        controller.updateSelectedIndex(index);
        controller.updateSelectedCategory(label);
      },
      child: Semantics(
        label: 'Select $label',
        child: Container(
          // margin: EdgeInsets.only(right: 12.0),
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: isSelected ? AppConstants.primaryColor2 : Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: AppConstants.secondaryColor),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 24.sp,
                color: isSelected ? Colors.white : AppConstants.primaryColor2,
              ),
              SizedBox(width: 8.0),
              Text(
                label,
                style: AppStyles.getFontStyle(
                  langController,
                  color: isSelected ? Colors.white : AppConstants.primaryColor2,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
