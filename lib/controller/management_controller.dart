import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../l10n/app_localizations.dart';
import '../model/client.dart';
import '../model/invoice.dart';
import '../model/monthly_sales.dart';
import '../model/product.dart';
import '../model/region.dart';
import '../model/users.dart';
import '../model/visit.dart';

class ManagementController extends ChangeNotifier {
  int selectedIndex = 0;
  String? selectedCategory;
  final List<Users> fav = [];
  List<Users> salesMen = [
    Users(
      id: 1,
      fullName: "John Doe",
      email: "john.doe@example.com",
      phone: 1234567890,
      role: "Salesman",
      status: "Active",
      totalSales: 50000.0,
      closedDeals: 15,
      targetAchievement: 90.0,
      region: Region(name: "New York"),
      // imageUrl: "assets/images/john_doe.jpg",
      visits: [
        Visit(visitDate: DateTime(2023, 10, 1)),
        Visit(visitDate: DateTime(2023, 10, 15)),
      ],
      invoices: [
        Invoice(
          products: [
            Product(price: 100.0),
            Product(price: 200.0),
          ],
        ),
      ],
      monthlySales: [
        MonthlySales(totalSales: 10000.0),
        MonthlySales(totalSales: 15000.0),
      ],
      clients: [
        Client(tradeName: "Client A"),
        Client(tradeName: "Client B"),
      ],
      createdAt: DateTime(2023, 1, 1),
      updatedAt: DateTime(2023, 10, 1),
    ),
    Users(
      id: 2,
      fullName: "Jane Smith",
      email: "jane.smith@example.com",
      phone: 9876543210,
      role: "Salesman",
      status: "Active",
      totalSales: 75000.0,
      closedDeals: 20,
      targetAchievement: 95.0,
      region: Region(name: "Los Angeles"),
      // imageUrl: "assets/images/jane_smith.jpg",
      visits: [
        Visit(visitDate: DateTime(2023, 9, 20)),
        Visit(visitDate: DateTime(2023, 10, 5)),
      ],
      invoices: [
        Invoice(
          products: [
            Product(price: 300.0),
            Product(price: 400.0),
          ],
        ),
      ],
      monthlySales: [
        MonthlySales(totalSales: 20000.0),
        MonthlySales(totalSales: 25000.0),
      ],
      clients: [
        Client(tradeName: "Client C"),
        Client(tradeName: "Client D"),
      ],
      createdAt: DateTime(2023, 2, 1),
      updatedAt: DateTime(2023, 10, 5),
    ),
    Users(
      id: 3,
      fullName: "Alice Johnson",
      email: "alice.johnson@example.com",
      phone: 5555555555,
      role: "Salesman",
      status: "Inactive",
      totalSales: 30000.0,
      closedDeals: 10,
      targetAchievement: 80.0,
      region: Region(name: "Chicago"),
      // imageUrl: "assets/images/alice_johnson.jpg",
      visits: [
        Visit(visitDate: DateTime(2023, 8, 10)),
        Visit(visitDate: DateTime(2023, 9, 1)),
      ],
      invoices: [
        Invoice(
          products: [
            Product(price: 500.0),
            Product(price: 600.0),
          ],
        ),
      ],
      monthlySales: [
        MonthlySales(totalSales: 12000.0),
        MonthlySales(totalSales: 18000.0),
      ],
      clients: [
        Client(tradeName: "Client E"),
        Client(tradeName: "Client F"),
      ],
      createdAt: DateTime(2023, 3, 1),
      updatedAt: DateTime(2023, 9, 10),
    ),
  ];
  Users? selectedUser;



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

  Future<void> fetchSalesMen() async {
    try {
      final response = await http.get(Uri.parse('https://api.example.com/salesmen'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        salesMen = data.map((json) => Users.fromJson(json)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load salesmen');
      }
    } catch (e) {
      print('Error fetching salesmen: $e');
    }
  }

  void deleteUser(Users user) {
    if (salesMen.contains(user)) {
      salesMen.remove(user);
      notifyListeners();

      _deleteUserFromAPI(user.id!);
    }
  }

  Future<void> _deleteUserFromAPI(int userId) async {
    try {
      final response = await http.delete(Uri.parse('https://api.example.com/salesmen/$userId'));

      if (response.statusCode != 200) {
        throw Exception('Failed to delete user');
      }
    } catch (e) {
      print('Error deleting user from API: $e');
    }
  }

  void toggleFavourite(BuildContext context, Users user) {
    if (fav.contains(user)) {
      fav.remove(user);
    } else {
      fav.add(user);
    }
    notifyListeners();
  }

  bool isFavourite(Users user){
    if(fav.contains(user)){
      return true;
    } else {
      return false;
    }
  }

  List<dynamic> getFilteredItems(BuildContext context, String? selectedCategory) {
    final localizations = AppLocalizations.of(context)!;

    if (selectedCategory == localizations.sales_men) {
      return salesMen;
    } else if (selectedCategory == localizations.clients) {
      return [];
    } else if (selectedCategory == localizations.products) {
      return [];
    } else {
      return [];
    }
  }
}