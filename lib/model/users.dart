import 'package:test_sales/model/client.dart';
import 'package:test_sales/model/invoice.dart';
import 'package:test_sales/model/monthly_sales.dart';
import 'package:test_sales/model/region.dart';
import 'package:test_sales/model/visit.dart';

class Users {
  int id;
  String? fullName;
  String? email;
  String? phone;
  String? password;
  String? role;
  String? status;
  final DateTime? createdAt;
  DateTime? updatedAt;
  int? routeId;
  String? imageUrl;
  double? totalSales;
  int? closedDeals;
  double? monthlyTarget;
  double? dailyTarget;
  List<Invoice>? invoices;
  List<Visit>? visits;
  List<MonthlySales>? monthlySales;
  List<Client>? clients;
  Region? region;
  String? notes;
  String? type;

  Users({
     this.id= 2,
    this.fullName = "Unknown",
    this.email = "N/A",
    this.phone = "0",
    this.password = "",
    this.role = "User",
    this.status = "Active",
    this.createdAt,
    this.updatedAt,
    this.region,
    this.routeId = 0,
    this.imageUrl = "assets/images/default_image.png",
    this.totalSales = 0.0,
    this.closedDeals = 0,
    this.monthlyTarget = 0.0,
    this.dailyTarget,
    this.invoices = const [],
    this.visits = const [],
    this.monthlySales = const [],
    this.clients = const [],
    this.notes = "",
    this.type = "",
  });

  /// Factory constructor to create a `Users` object from JSON.
  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'],
      fullName: json['full_name'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      role: json['role'],
      status: json['status'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      routeId: json['route_id'],
      imageUrl: json['image_url'],
      totalSales: (json['total_sales'] as num?)?.toDouble(),
      closedDeals: json['closed_deals'],
      monthlyTarget: (json['target'] as num?)?.toDouble(),
      invoices: (json['invoices'] as List<dynamic>?)
          ?.map((invoiceJson) => Invoice.fromJson(invoiceJson))
          .toList() ??
          [],
      visits: (json['visits'] as List<dynamic>?)
          ?.map((visitJson) => Visit.fromJson(visitJson))
          .toList() ??
          [],
      monthlySales: (json['monthly_sales'] as List<dynamic>?)
          ?.map((monthlySaleJson) => MonthlySales.fromJson(monthlySaleJson))
          .toList() ??
          [],
      clients: (json['clients'] as List<dynamic>?)
          ?.map((clientJson) => Client.fromJson(clientJson))
          .toList() ??
          [],
      region: json['region'] != null ? Region.fromJson(json['region']) : null,
      notes: json['notes'],
    );
  }

  /// Converts the `Users` object to JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'password': password,
      'role': role,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'route_id': routeId,
      'image_url': imageUrl,
      'total_sales': totalSales,
      'closed_deals': closedDeals,
      'target': monthlyTarget,
      'invoices': invoices?.map((invoice) => invoice.toJson()).toList(),
      'visits': visits?.map((visit) => visit.toJson()).toList(),
      'monthly_sales': monthlySales?.map((monthlySale) => monthlySale.toJson()).toList(),
      'clients': clients?.map((client) => client.toJson()).toList(),
      'region': region?.toJson(),
      'notes': notes,
    };
  }
}