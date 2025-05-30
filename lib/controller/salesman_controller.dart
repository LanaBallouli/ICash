import 'package:flutter/cupertino.dart';

import '../model/client.dart';
import '../model/invoice.dart';
import '../model/monthly_sales.dart';
import '../model/product.dart';
import '../model/region.dart';
import '../model/salesman.dart';
import '../model/visit.dart';

class SalesmanController extends ChangeNotifier {
  final List<SalesMan> fav = [];
  List<SalesMan> salesMen = [
    SalesMan(
        id: 1,
        fullName: "John Doe",
        email: "john.doe@example.com",
        phone: "1234567890",
        role: "Salesman",
        dailyTarget: 200,
        type: "Cash",
        password: "@Lana123",
        status: "Active",
        totalSales: 50000.0,
        closedDeals: 15,
        monthlyTarget: 90.0,
        clientsId: [2],
        visits: [
          Visit(
              visitDate: DateTime(2023, 10, 1),
              nextVisitTime: DateTime(2024, 8, 2),
              id: 1,
              clientId: 2,
              userId: 1,
          ),
          Visit(visitDate: DateTime(2023, 10, 15)),
        ],
        monthlySales: [
          MonthlySales(totalSales: 10000.0),
          MonthlySales(totalSales: 15000.0),
        ],
        createdAt: DateTime(2023, 1, 1),
        updatedAt: DateTime(2023, 10, 1),
        imageUrl: "assets/images/google-maps.png",
        notes: "so many notes"),
  ];

  addNewUser(SalesMan user) {
    salesMen.add(user);
    notifyListeners();
  }

  updateUser({
    required SalesMan user,
    required int index,
  }) {
    salesMen[index] = user;
    notifyListeners();
  }

  deleteUser(SalesMan user) {
    if (salesMen.contains(user)) {
      salesMen.remove(user);
      notifyListeners();
    }
  }

  toggleFavourite(BuildContext context, SalesMan user) {
    if (fav.contains(user)) {
      fav.remove(user);
    } else {
      fav.add(user);
    }
    notifyListeners();
  }

  bool isFavourite(SalesMan user) {
    if (fav.contains(user)) {
      return true;
    } else {
      return false;
    }
  }
}
