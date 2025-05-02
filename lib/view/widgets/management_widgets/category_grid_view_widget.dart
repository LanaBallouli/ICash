import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_sales/model/users.dart';
import 'package:test_sales/view/widgets/management_widgets/management_item_widget.dart';

class CategoryGridViewWidget extends StatelessWidget {
  final List<dynamic> items;

  const CategoryGridViewWidget({required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0.w),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
                childAspectRatio: 0.57,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 10.h,
              ),
              itemBuilder: (context, index) {
                return ManagementItemWidget(users: items[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
