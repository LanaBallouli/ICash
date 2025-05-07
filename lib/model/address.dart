import 'package:test_sales/model/region.dart';

class Address {
  final String? street;
  final int? buildingNumber;
  final Region? regionName;
  final String? additionalDirections;
  final double? latitude;
  final double? longitude;

  Address({
    this.street,
    this.buildingNumber,
    this.regionName,
    this.additionalDirections,
    this.latitude,
    this.longitude,
  });
}
