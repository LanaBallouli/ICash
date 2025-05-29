import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_constants.dart';
import 'package:test_sales/controller/clients_controller.dart';
import 'package:test_sales/controller/management_controller.dart';
import 'package:test_sales/controller/salesman_controller.dart';
import 'package:test_sales/l10n/app_localizations.dart';
import 'package:test_sales/view/screens/management_screens/salesmen_screens/add_salesman_screen.dart';
import 'package:test_sales/view/screens/management_screens/client/set_location_screen.dart';
import 'package:test_sales/view/widgets/main_widgets/input_widget.dart';
import 'package:test_sales/view/widgets/main_widgets/main_appbar_widget.dart';
import '../../widgets/management_widgets/main/category_buttons_widget.dart';
import '../../widgets/management_widgets/main/category_grid_view_widget.dart';
import '../../widgets/management_widgets/main/category_list_view_widget.dart';

class ManagementScreen extends StatelessWidget {
  const ManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    final clientsController =
        Provider.of<ClientsController>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: MainAppbarWidget(
          title: AppLocalizations.of(context)!.management_screen,
        ),
        body: Consumer2<SalesmanController, ManagementController>(
          builder: (context, salesmanController, managementController, child) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              salesmanController.salesMen;
            });
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CategoryButtonsWidget(),
                  SizedBox(height: 18.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: InputWidget(
                      textEditingController: searchController,
                      obscureText: false,
                      backgroundColor: AppConstants.buttonColor,
                      label: AppLocalizations.of(context)!.search,
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.filter_list),
                      ),
                    ),
                  ),
                  if (managementController.selectedCategory ==
                      AppLocalizations.of(context)!.clients)
                    CategoryListViewWidget(
                      items: clientsController.clients
                    )
                  else
                    CategoryGridViewWidget(items: salesmanController.salesMen),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "1",
          shape: OvalBorder(),
          backgroundColor: AppConstants.primaryColor2,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 25.sp,
          ),
          onPressed: () {
            final managementController =
                Provider.of<ManagementController>(context, listen: false);

            if (managementController.selectedCategory ==
                AppLocalizations.of(context)!.sales_men) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddSalesmanScreen()),
              );
            } else if (managementController.selectedCategory ==
                AppLocalizations.of(context)!.clients) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SetLocationScreen()),
              );
            }
          },
        ),
        resizeToAvoidBottomInset: false);
  }
}
