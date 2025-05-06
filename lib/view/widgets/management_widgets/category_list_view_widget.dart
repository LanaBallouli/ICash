import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/view/widgets/management_widgets/clients_widget.dart';

import '../../../controller/management_controller.dart';

class CategoryListViewWidget extends StatelessWidget {
  final List<dynamic> items;

  const CategoryListViewWidget({super.key, required this.items});

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
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: items.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ClientsWidget(
                          client: items[index],
                          index: index,
                        ),
                        SizedBox(height: 15.h,)
                      ],
                    );
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
