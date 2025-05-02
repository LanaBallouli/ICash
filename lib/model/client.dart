import 'package:test_sales/model/region.dart';
import 'package:test_sales/model/users.dart';
import 'package:test_sales/model/visit.dart';

class Client {
  int? id;
  String? clientNumber;
  Users? userId;
  String? tradeName;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? createdBy;
  double? latitude;
  double? longitude;
  Region? region;
  int? balance;
  String? commercialRegistration;
  String? professionLicensePath;
  String? nationalId;
  List<Visit>? visits;

  Client({
    this.id,
    this.clientNumber,
    this.userId,
    this.tradeName,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.latitude,
    this.longitude,
    this.region,
    this.balance,
    this.commercialRegistration,
    this.professionLicensePath,
    this.nationalId,
    this.visits,
  });

  /// Factory constructor to create a `Client` object from JSON.
  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      clientNumber: json['client_number'],
      userId: json['user'] != null ? Users.fromJson(json['user']) : null,
      tradeName: json['trade_name'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      createdBy: json['created_by'],
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      region: json['region'] != null ? Region.fromJson(json['region']) : null,
      balance: json['balance'],
      commercialRegistration: json['commercial_registration'],
      professionLicensePath: json['profession_license_path'],
      nationalId: json['national_id'],
      visits: (json['visits'] as List<dynamic>?)
          ?.map((visitJson) => Visit.fromJson(visitJson))
          .toList(),
    );
  }

  /// Converts the `Client` object to JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'client_number': clientNumber,
      'user': userId?.toJson(),
      'trade_name': tradeName,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'created_by': createdBy,
      'latitude': latitude,
      'longitude': longitude,
      'region': region?.toJson(),
      'balance': balance,
      'commercial_registration': commercialRegistration,
      'profession_license_path': professionLicensePath,
      'national_id': nationalId,
      'visits': visits?.map((visit) => visit.toJson()).toList(),
    };
  }
}