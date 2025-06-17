import 'package:flutter/cupertino.dart';

import '../repository/sales_repository.dart';

class SalesController extends ChangeNotifier {
  final SalesRepository repository;
  double monthlyTarget = 10000.0;
  double monthlySales = 0.0;

  SalesController(this.repository);

  Future<double> getDailySales(BuildContext context) async {

    try {
      final response = await repository.getDailySales();
      return response;
    } catch (e) {
      print("Error fetching daily sales: $e");
      return 0.0;
    }
  }

  Future<void> fetchMonthlySales(BuildContext context) async {
    try {
      final total = await repository.getMonthlySales();
      monthlySales = total;
    } catch (e) {
      print("Error fetching monthly sales: $e");
    }
    notifyListeners();
  }
}