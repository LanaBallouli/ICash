import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_constants.dart';
import 'package:test_sales/controller/management_controller.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import 'package:test_sales/view/widgets/main_widgets/input_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/main_appbar_widget.dart';
import '../../widgets/management_widgets/category_buttons_widget.dart';
import '../../widgets/management_widgets/category_grid_view_widget.dart';

class ManagementScreen extends StatelessWidget {
  const ManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the search controller
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppbarWidget(
        title: AppLocalizations.of(context)!.management_screen,
      ),
      body: Consumer<ManagementController>(
        builder: (context, managementController, child) {
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Category buttons for selecting a category
                CategoryButtonsWidget(),

                SizedBox(height: 18.h),

                // Search input field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: InputWidget(
                    textEditingController: searchController,
                    obscureText: false,
                    backgroundColor: AppConstants.buttonColor,
                    label: AppLocalizations.of(context)!.search,
                    suffixIcon: IconButton(
                      onPressed: () {
                        // Perform search or filtering logic here
                        print("Search triggered for: ${searchController.text}");
                      },
                      icon: const Icon(Icons.filter_list),
                    ),
                  ),
                ),

                // Display the grid view if a valid category is selected
                if ([
                  AppLocalizations.of(context)!.sales_men,
                  AppLocalizations.of(context)!.clients,
                  AppLocalizations.of(context)!.products,
                ].contains(managementController.selectedCategory))
                  CategoryGridViewWidget(
                    items: managementController.getFilteredItems(
                      context,
                      managementController.selectedCategory,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}