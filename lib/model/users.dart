import 'package:test_sales/model/visit.dart';

import 'invoice.dart';
import 'monthly_sales.dart';

class Users {
  String? fullName;
  String? email;
  int? phone;
  String? password;
  String? role;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? region;
  int? routeId;
  String? imageUrl;
  double? totalSales;
  int? closedDeals;
  double? targetAchievement;
  List<Invoice>? invoices;
  List<Visit>? visits;
  List<MonthlySales>? monthlySales;

  Users({
    this.fullName,
    this.email,
    this.phone,
    this.password,
    this.role,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.region,
    this.routeId,
    this.imageUrl,
    this.totalSales,
    this.closedDeals,
    this.targetAchievement,
    this.invoices,
    this.visits,
    this.monthlySales,
  });
}
