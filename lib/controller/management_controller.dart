import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/controller/lang_controller.dart';
import 'package:test_sales/model/invoice.dart';
import 'package:test_sales/model/monthly_sales.dart';
import 'package:test_sales/model/visit.dart';
import 'package:test_sales/view/widgets/management_widgets/management_item_widget.dart';
import '../app_constants.dart';
import '../l10n/app_localizations.dart';
import '../model/users.dart';
import '../view/widgets/custom_button_widget.dart';

class ManagementController extends ChangeNotifier {
  int selectedIndex = 0;
  String? selectedCategory;
  final List<Users> fav = [];
  late Users users;

  void initializeSelectedCategory(BuildContext context) {
    selectedCategory = AppLocalizations.of(context)!.sales_men;
    notifyListeners();
  }

  void selectedUsers(Users selectedUser) {
    users = selectedUser;
    notifyListeners();
  }

  bool isFavourite(Users users) {
    return fav.contains(users);
  }

  void toggleFavourite(BuildContext context, Users users) {
    if (fav.contains(users)) {
      _showConfirmationDialog(context, users);
    } else {
      fav.add(users);
      notifyListeners();
    }
  }

  void updateSelectedCategory(String category) {
    if (selectedCategory != category) {
      selectedCategory = category;
      notifyListeners();
    }
  }

  void updateSelectedIndex(int index) {
    if (selectedIndex != index) {
      selectedIndex = index;
      notifyListeners();
    }
  }

  List<ManagementItemWidget> getItemsForCategory(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    if (localizations == null) {
      throw Exception("Localization not available in the current context.");
    }

    if (selectedCategory == localizations.sales_men) {
      return salesMen;
    } else if (selectedCategory == localizations.clients) {
      return clients;
    } else if (selectedCategory == localizations.products) {
      return products;
    } else {
      return [];
    }
  }

  final List<ManagementItemWidget> salesMen = [
    ManagementItemWidget(
        users: Users(
            status: "Active",
            role: "Sales man",
            phone: 0799471732,
            fullName: "Lana Baha",
            email: "lanabaloley@gmail.com",
            createdAt: DateTime.now(),
            imageUrl: "assets/images/default_image.png",
            visits: [Visit(visitDate: DateTime.now())],
            monthlySales: [MonthlySales(totalSales: 30)],
            password: "@Lana123",
            region: "Amman",
            closedDeals: 5,
            routeId: 1,
            totalSales: 3333,
            targetAchievement: 90,
            invoices: [Invoice(totalAmount: 30)],
            updatedAt: DateTime.now())),
    ManagementItemWidget(
        users: Users(
            status: "Active",
            role: "Sales man",
            phone: 0799471732,
            invoices: [Invoice(totalAmount: 30)],
            closedDeals: 5,
            fullName: "Lana Baha",
            email: "lanabaloley@gmail.com",
            createdAt: DateTime.now(),
            imageUrl: "assets/images/default_image.png",
            visits: [Visit(visitDate: DateTime.now())],
            monthlySales: [MonthlySales(totalSales: 30)],
            password: "@Lana123",
            region: "Amman",
            totalSales: 31113,
            targetAchievement: 90,
            routeId: 1,
            updatedAt: DateTime.now())),
    ManagementItemWidget(
        users: Users(
            status: "Active",
            role: "Sales man",
            phone: 0799471732,
            fullName: "Lana Baha",
            monthlySales: [MonthlySales(totalSales: 30)],
            closedDeals: 5,
            email: "lanabaloley@gmail.com",
            createdAt: DateTime.now(),
            invoices: [Invoice(totalAmount: 30)],
            visits: [Visit(visitDate: DateTime.now())],
            password: "@Lana123",
            region: "Amman",
            totalSales: 3333,
            routeId: 1,
            targetAchievement: 90,
            updatedAt: DateTime.now())),
    ManagementItemWidget(
        users: Users(
            status: "Active",
            role: "Sales man",
            phone: 0799471732,
            fullName: "Lana Baha",
            closedDeals: 5,
            email: "lanabaloley@gmail.com",
            invoices: [Invoice(totalAmount: 30)],
            createdAt: DateTime.now(),
            totalSales: 3333,
            imageUrl: "assets/images/default_image.png",
            password: "@Lana123",
            visits: [Visit(visitDate: DateTime.now())],
            region: "Amman",
            routeId: 1,
            targetAchievement: 90,
            updatedAt: DateTime.now())),
  ];

  final List<ManagementItemWidget> clients = [
    ManagementItemWidget(
        users: Users(
            status: "Active",
            role: "Sales man",
            phone: 0799471732,
            fullName: "Lana Baha",
            email: "lanabaloley@gmail.com",
            invoices: [Invoice(totalAmount: 30)],
            createdAt: DateTime.now(),
            imageUrl: "assets/images/default_image.png",
            password: "@Lana123",
            closedDeals: 5,
            totalSales: 3333,
            monthlySales: [MonthlySales(totalSales: 30)],
            visits: [Visit(visitDate: DateTime.now())],
            region: "Amman",
            routeId: 1,
            targetAchievement: 90,
            updatedAt: DateTime.now())),
    ManagementItemWidget(
        users: Users(
            status: "Active",
            role: "Sales man",
            phone: 0799471732,
            fullName: "Lana Baha",
            closedDeals: 5,
            email: "lanabaloley@gmail.com",
            createdAt: DateTime.now(),
            invoices: [Invoice(totalAmount: 30)],
            imageUrl: "assets/images/default_image.png",
            monthlySales: [MonthlySales(totalSales: 30)],
            password: "@Lana123",
            totalSales: 3333,
            region: "Amman",
            routeId: 1,
            visits: [Visit(visitDate: DateTime.now())],
            targetAchievement: 90,
            updatedAt: DateTime.now())),
    ManagementItemWidget(
        users: Users(
            status: "Active",
            role: "Sales man",
            phone: 0799471732,
            fullName: "Lana Baha",
            email: "lanabaloley@gmail.com",
            createdAt: DateTime.now(),
            imageUrl: "assets/images/default_image.png",
            password: "@Lana123",
            totalSales: 3333,
            region: "Amman",
            monthlySales: [MonthlySales(totalSales: 30)],
            routeId: 1,
            closedDeals: 5,
            visits: [Visit(visitDate: DateTime.now())],
            invoices: [Invoice(totalAmount: 30)],
            targetAchievement: 90,
            updatedAt: DateTime.now())),
    ManagementItemWidget(
        users: Users(
            status: "Active",
            role: "Sales man",
            phone: 0799471732,
            fullName: "Lana Baha",
            email: "lanabaloley@gmail.com",
            totalSales: 3333,
            invoices: [Invoice(totalAmount: 30)],
            createdAt: DateTime.now(),
            imageUrl: "assets/images/default_image.png",
            monthlySales: [MonthlySales(totalSales: 30)],
            password: "@Lana123",
            region: "Amman",
            visits: [Visit(visitDate: DateTime.now())],
            routeId: 1,
            closedDeals: 5,
            targetAchievement: 90,
            updatedAt: DateTime.now())),
  ];

  final List<ManagementItemWidget> products = [
    ManagementItemWidget(
        users: Users(
            status: "Active",
            role: "Sales man",
            phone: 0799471732,
            fullName: "Lana Baha",
            email: "lanabaloley@gmail.com",
            createdAt: DateTime.now(),
            imageUrl: "assets/images/default_image.png",
            password: "@Lana123",
            totalSales: 3333,
            region: "Amman",
            routeId: 1,
            invoices: [Invoice(totalAmount: 30)],
            monthlySales: [MonthlySales(totalSales: 30)],
            closedDeals: 5,
            visits: [Visit(visitDate: DateTime.now())],
            targetAchievement: 90,
            updatedAt: DateTime.now())),
    ManagementItemWidget(
        users: Users(
            status: "Active",
            role: "Sales man",
            phone: 0799471732,
            fullName: "Lana Baha",
            totalSales: 3333,
            email: "lanabaloley@gmail.com",
            createdAt: DateTime.now(),
            imageUrl: "assets/images/default_image.png",
            monthlySales: [MonthlySales(totalSales: 30)],
            password: "@Lana123",
            region: "Amman",
            targetAchievement: 90,
            visits: [Visit(visitDate: DateTime.now())],
            invoices: [Invoice(totalAmount: 30)],
            routeId: 1,
            closedDeals: 5,
            updatedAt: DateTime.now())),
    ManagementItemWidget(
      users: Users(
        status: "Active",
        role: "Sales man",
        phone: 0799471732,
        fullName: "Lana Baha",
        email: "lanabaloley@gmail.com",
        createdAt: DateTime.now(),
        imageUrl: "assets/images/default_image.png",
        monthlySales: [MonthlySales(totalSales: 30)],
        password: "@Lana123",
        totalSales: 3333,
        targetAchievement: 90,
        region: "Amman",
        routeId: 1,
        updatedAt: DateTime.now(),
        closedDeals: 7,
        invoices: [Invoice(totalAmount: 30)],
        visits: [Visit(visitDate: DateTime.now())],
      ),
    ),
    ManagementItemWidget(
        users: Users(
            status: "Active",
            role: "Sales man",
            phone: 0799471732,
            fullName: "Lana Baha",
            totalSales: 3333,
            email: "lanabaloley@gmail.com",
            createdAt: DateTime.now(),
            imageUrl: "assets/images/default_image.png",
            monthlySales: [MonthlySales(totalSales: 30)],
            password: "@Lana123",
            region: "Amman",
            routeId: 1,
            targetAchievement: 90,
            invoices: [Invoice(totalAmount: 30)],
            visits: [Visit(visitDate: DateTime.now())],
            closedDeals: 5,
            updatedAt: DateTime.now())),
  ];

  void _showConfirmationDialog(BuildContext context, Users users) {
    final LangController langController =
        Provider.of<LangController>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Text(
            AppLocalizations.of(context)!.remove_from_favorites_confirmation,
            textAlign: TextAlign.center,
            style: AppStyles.getFontStyle(
              langController,
              fontSize: 14,
              color: Colors.black54,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: [
            CustomButtonWidget(
              title: AppLocalizations.of(context)!.yes,
              colors: [AppConstants.primaryColor2, AppConstants.primaryColor2],
              height: 60,
              borderRadius: 12,
              titleColor: Colors.white,
              width: 300,
              onPressed: () {
                fav.remove(users);
                notifyListeners();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
