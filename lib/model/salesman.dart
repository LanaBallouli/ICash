import 'package:test_sales/model/monthly_sales.dart';
import 'package:test_sales/model/visit.dart';

class SalesMan {
  final int id;
  final String? fullName;
  final String? email;
  final String? phone;
  final String? password;
  final String? role;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? routeId;
  final String? imageUrl;
  final double? totalSales;
  final int? closedDeals;
  final double? monthlyTarget;
  final double? dailyTarget;
  final List<int>? invoicesIds;
  final List<Visit>? visits;
  final List<MonthlySales>? monthlySales;
  final List<int>? clientsId;
  final int? regionId;
  final String? notes;
  final String? type;

  SalesMan({
     this.id= 2,
    this.fullName = "Unknown",
    this.email = "N/A",
    this.phone = "0",
    this.password = "",
    this.role = "User",
    this.status = "Active",
    this.createdAt,
    this.updatedAt,
    this.regionId,
    this.routeId = 0,
    this.imageUrl = "assets/images/default_image.png",
    this.totalSales = 0.0,
    this.closedDeals = 0,
    this.monthlyTarget = 0.0,
    this.dailyTarget,
    this.invoicesIds = const [],
    this.visits = const [],
    this.monthlySales = const [],
    this.clientsId = const [],
    this.notes = "",
    this.type = "",
  });


}