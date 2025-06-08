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
    final clientsController = Provider.of<ClientsController>(context);
    final salesmanController = Provider.of<SalesmanController>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppbarWidget(
        title: AppLocalizations.of(context)!.management_screen,
      ),
      body: Consumer2<SalesmanController, ClientsController>(
        builder: (context, salesmanCtrl, clientsCtrl, child) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final managementController =
            Provider.of<ManagementController>(context, listen: false);

            if (managementController.selectedCategory ==
                AppLocalizations.of(context)!.clients) {
              if (!clientsCtrl.isLoading && !clientsCtrl.hasLoadedOnce) {
                clientsController.fetchAllClients();
              }
            } else {
              if (!salesmanCtrl.isLoading && !salesmanCtrl.hasLoadedOnce) {
                salesmanController.fetchSalesmen();
              }
            }
          });

          final managementController =
          Provider.of<ManagementController>(context);

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
                      icon: Icon(Icons.filter_list),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                if (managementController.selectedCategory ==
                    AppLocalizations.of(context)!.clients)
                  _buildClientContent(context, clientsController)
                else
                  _buildSalesmanContent(context, salesmanController),
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
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _buildClientContent(BuildContext context, ClientsController controller) {
    final local = AppLocalizations.of(context)!;

    if (controller.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (controller.errorMessage.isNotEmpty) {
      return Center(
        child: Text(
          controller.errorMessage,
          style: TextStyle(color: Colors.red, fontSize: 14.sp),
        ),
      );
    }

    if (controller.clients.isEmpty) {
      return Center(
        child: Text(
          "local.no_clients_yet",
          style: TextStyle(fontSize: 16.sp, color: Colors.black54),
        ),
      );
    }

    return CategoryListViewWidget(items: controller.clients);
  }

  Widget _buildSalesmanContent(BuildContext context, SalesmanController controller) {
    final local = AppLocalizations.of(context)!;

    if (controller.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (controller.errorMessage.isNotEmpty) {
      return Center(
        child: Text(
          controller.errorMessage,
          style: TextStyle(color: Colors.red, fontSize: 14.sp),
        ),
      );
    }

    if (controller.salesMen.isEmpty) {
      return Center(
        child: Text(
          "local.no_salesmen_yet",
          style: TextStyle(fontSize: 16.sp, color: Colors.black54),
        ),
      );
    }

    return CategoryGridViewWidget(items: controller.salesMen);
  }
}