import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  void toggleFavourite(BuildContext context, Users Users) {
    if (fav.contains(Users)) {
      _showConfirmationDialog(context, Users);
    } else {
      fav.add(Users);
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
      return pizza;
    } else if (selectedCategory == localizations.clients) {
      return burger;
    } else if (selectedCategory == localizations.products) {
      return sandwich;
    } else {
      return [];
    }
  }

  final List<ManagementItemWidget> pizza = [
    ManagementItemWidget(
        users: Users(
            status: "Active",
            role: "Sales man",
            phone: 0799471732,
            fullName: "Lana Baha",
            email: "lanabaloley@gmail.com",
            createdAt: DateTime.now(),
            imageUrl: "assets/images/accept.png",
            password: "@Lana123",
            regionId: 1,
            routeId: 1,
            updatedAt: DateTime.now())),
    ManagementItemWidget(
        users: Users(
            status: "Active",
            role: "Sales man",
            phone: 0799471732,
            fullName: "Lana Baha",
            email: "lanabaloley@gmail.com",
            createdAt: DateTime.now(),
            imageUrl: "assets/images/accept.png",
            password: "@Lana123",
            regionId: 1,
            routeId: 1,
            updatedAt: DateTime.now())),
    ManagementItemWidget(
        users: Users(
            status: "Active",
            role: "Sales man",
            phone: 0799471732,
            fullName: "Lana Baha",
            email: "lanabaloley@gmail.com",
            createdAt: DateTime.now(),
            imageUrl: "assets/images/accept.png",
            password: "@Lana123",
            regionId: 1,
            routeId: 1,
            updatedAt: DateTime.now())),
    ManagementItemWidget(
        users: Users(
            status: "Active",
            role: "Sales man",
            phone: 0799471732,
            fullName: "Lana Baha",
            email: "lanabaloley@gmail.com",
            createdAt: DateTime.now(),
            imageUrl: "assets/images/accept.png",
            password: "@Lana123",
            regionId: 1,
            routeId: 1,
            updatedAt: DateTime.now())),
  ];

  final List<ManagementItemWidget> burger = [
    ManagementItemWidget(
        users: Users(
            status: "Active",
            role: "Sales man",
            phone: 0799471732,
            fullName: "Lana Baha",
            email: "lanabaloley@gmail.com",
            createdAt: DateTime.now(),
            imageUrl: "assets/images/accept.png",
            password: "@Lana123",
            regionId: 1,
            routeId: 1,
            updatedAt: DateTime.now())),
    ManagementItemWidget(
        users: Users(
            status: "Active",
            role: "Sales man",
            phone: 0799471732,
            fullName: "Lana Baha",
            email: "lanabaloley@gmail.com",
            createdAt: DateTime.now(),
            imageUrl: "assets/images/accept.png",
            password: "@Lana123",
            regionId: 1,
            routeId: 1,
            updatedAt: DateTime.now())),
    ManagementItemWidget(
        users: Users(
            status: "Active",
            role: "Sales man",
            phone: 0799471732,
            fullName: "Lana Baha",
            email: "lanabaloley@gmail.com",
            createdAt: DateTime.now(),
            imageUrl: "assets/images/accept.png",
            password: "@Lana123",
            regionId: 1,
            routeId: 1,
            updatedAt: DateTime.now())),
    ManagementItemWidget(
        users: Users(
            status: "Active",
            role: "Sales man",
            phone: 0799471732,
            fullName: "Lana Baha",
            email: "lanabaloley@gmail.com",
            createdAt: DateTime.now(),
            imageUrl: "assets/images/accept.png",
            password: "@Lana123",
            regionId: 1,
            routeId: 1,
            updatedAt: DateTime.now())),
  ];

  final List<ManagementItemWidget> sandwich = [
    ManagementItemWidget(
        users: Users(
            status: "Active",
            role: "Sales man",
            phone: 0799471732,
            fullName: "Lana Baha",
            email: "lanabaloley@gmail.com",
            createdAt: DateTime.now(),
            imageUrl: "assets/images/accept.png",
            password: "@Lana123",
            regionId: 1,
            routeId: 1,
            updatedAt: DateTime.now())),
    ManagementItemWidget(
        users: Users(
            status: "Active",
            role: "Sales man",
            phone: 0799471732,
            fullName: "Lana Baha",
            email: "lanabaloley@gmail.com",
            createdAt: DateTime.now(),
            imageUrl: "assets/images/accept.png",
            password: "@Lana123",
            regionId: 1,
            routeId: 1,
            updatedAt: DateTime.now())),
    ManagementItemWidget(
        users: Users(
            status: "Active",
            role: "Sales man",
            phone: 0799471732,
            fullName: "Lana Baha",
            email: "lanabaloley@gmail.com",
            createdAt: DateTime.now(),
            imageUrl: "assets/images/accept.png",
            password: "@Lana123",
            regionId: 1,
            routeId: 1,
            updatedAt: DateTime.now())),
    ManagementItemWidget(
        users: Users(
            status: "Active",
            role: "Sales man",
            phone: 0799471732,
            fullName: "Lana Baha",
            email: "lanabaloley@gmail.com",
            createdAt: DateTime.now(),
            imageUrl: "assets/images/accept.png",
            password: "@Lana123",
            regionId: 1,
            routeId: 1,
            updatedAt: DateTime.now())),
  ];

  void _showConfirmationDialog(BuildContext context, Users users) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Text(
            AppLocalizations.of(context)!.remove_from_favorites_confirmation,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: [
            CustomButtonWidget(
              title: AppLocalizations.of(context)!.yes,
              colors: [AppConstants.buttonColor, AppConstants.buttonColor],
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
