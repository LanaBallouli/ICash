class Address {
  final int? id;
  final String? street;
  final int? buildingNumber;
  final String? additionalDirections;
  final double latitude;
  final double longitude;

  Address({
    this.id,
    this.street,
    this.buildingNumber,
    this.additionalDirections,
    required this.latitude,
    required this.longitude,
  });

  Address copyWith({
    int? id,
    String? street,
    int? buildingNumber,
    String? additionalDirections,
    double? latitude,
    double? longitude,
  }) {
    return Address(
      id: id ?? this.id,
      street: street ?? this.street,
      buildingNumber: buildingNumber ?? this.buildingNumber,
      additionalDirections: additionalDirections ?? this.additionalDirections,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      street: json['street'],
      buildingNumber: json['building_number'],
      additionalDirections: json['additional_directions'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'street': street,
      'building_number': buildingNumber,
      'additional_directions': additionalDirections,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}