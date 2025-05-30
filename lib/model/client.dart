import 'package:test_sales/model/address.dart';
import 'package:test_sales/model/invoice.dart';
import 'package:test_sales/model/region.dart';
import 'package:test_sales/model/salesman.dart';
import 'package:test_sales/model/visit.dart';

class Client {
  final int? id;
  final String? clientNumber;
  final String? tradeName;
  final String? personInCharge;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? addressId;
  final int? regionId;
  final int? balance;
  final String? commercialRegistration;
  final String? professionLicensePath;
  final String? nationalId;
  final String? phone;
  final String? status;
  final String? type;
  final List<int>? invoicesIds;
  final List<int>? assignedSalesmenIds;
  final String? notes;

  const Client({
    this.id,
    this.clientNumber,
    this.tradeName,
    this.createdAt,
    this.updatedAt,
    this.regionId,
    this.addressId,
    this.balance,
    this.commercialRegistration,
    this.professionLicensePath,
    this.nationalId,
    this.visitsIds,
    this.phone,
    this.status,
    this.type,
    this.invoicesIds,
    this.assignedSalesmenIds,
    this.notes,
    this.personInCharge
  });


}