import 'package:intl/intl.dart';

class SalesMan {
  final int? id;
  final String fullName;
  final String email;
  final String phone;
  final String password;
  final String role;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String imageUrl;
  final double totalSales;
  final int closedDeals;
  final double monthlyTarget;
  final double dailyTarget;
  final int regionId;
  final String notes;
  final String type;
  final String? supabaseUid;

  SalesMan({
    this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
    this.role = "User",
    this.status = "Active",
    required this.createdAt,
    required this.updatedAt,
    this.imageUrl = "assets/images/default_image.png",
    this.totalSales = 0.0,
    this.closedDeals = 0,
    this.monthlyTarget = 0.0,
    this.dailyTarget = 0.0,
    required this.regionId,
    this.notes = "",
    this.type = "",
    this.supabaseUid,
  });

  factory SalesMan.fromJson(Map<String, dynamic> json) {
    return SalesMan(
      id: json['id'],
      fullName: json['full_name'] ?? "",
      email: json['email'] ?? "",
      phone: json['phone'] ?? "",
      password: json['password'] ?? "",
      role: json['role'] ?? "User",
      status: json['status'] ?? "Active",
      createdAt: safeParseDate(json['created_at']),
      updatedAt: safeParseDate(json['updated_at']),
      imageUrl: json['image_url'] ?? "assets/images/default_image.png",
      totalSales: json['total_sales']?.toDouble() ?? 0.0,
      closedDeals: json['closed_deals'] ?? 0,
      monthlyTarget: json['monthly_target']?.toDouble() ?? 0.0,
      dailyTarget: json['daily_target']?.toDouble() ?? 0.0,
      regionId: json['region_id'] ?? 1,
      notes: json['notes'] ?? "",
      type: json['type'] ?? "",
      supabaseUid: json['supabase_uid'],
    );
  }

  static DateTime safeParseDate(dynamic date) {
    if (date == null) return DateTime.now();

    if (date is String) {
      try {
        if (date.contains('T')) {
          return DateTime.parse(date); // ISO format
        } else {
          return DateFormat('yyyy-MM-dd HH:mm:ss').parse(date);
        }
      } catch (e) {
        return DateTime.now();
      }
    }

    if (date is int) {
      return DateTime.fromMillisecondsSinceEpoch(date * 1000);
    }

    return DateTime.now();
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'password': password,
      'role': role,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'image_url': imageUrl,
      'total_sales': totalSales,
      'closed_deals': closedDeals,
      'monthly_target': monthlyTarget,
      'daily_target': dailyTarget,
      'region_id': regionId,
      'notes': notes,
      'type': type,
      'supabase_uid': supabaseUid ?? "", // Store Supabase UID for future reference
    };
  }
}