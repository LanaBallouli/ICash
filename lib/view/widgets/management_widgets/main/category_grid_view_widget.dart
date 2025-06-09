import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/controller/management_controller.dart';
import 'package:test_sales/model/product.dart';
import 'package:test_sales/model/salesman.dart';
import '../salesman_widgets/management_item_widget.dart';

class CategoryGridViewWidget extends StatelessWidget {
  final List<dynamic> items;

  const CategoryGridViewWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0.w),
            child: Consumer<ManagementController>(
              builder: (context, managementController, child) {
                return GridView.builder(
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
                    final item = items[index];

                    if (item is SalesMan) {
                      return ManagementItemWidget<SalesMan>(
                        item: item,
                        index: index,
                        isProduct: false,
                      );
                    } else if (item is Product) {
                      return ManagementItemWidget<Product>(
                        item: item,
                        index: index,
                        isProduct: true,
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}