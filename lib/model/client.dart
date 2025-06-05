class Client {
  final int? id;
  final String tradeName;
  final String personInCharge;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int addressId; // Foreign key referencing Address
  final int regionId; // Foreign key referencing Region
  final int balance;
  final String commercialRegistration;
  final String professionLicensePath;
  final String nationalId;
  final String phone;
  final String status;
  final String type;
  final String notes;
  final List<int> invoiceIds; // List of foreign keys referencing Invoice

  Client({
    this.id,
    required this.tradeName,
    required this.personInCharge,
    required this.createdAt,
    required this.updatedAt,
    required this.addressId,
    required this.regionId,
    this.balance = 0,
    this.commercialRegistration = "",
    this.professionLicensePath = "",
    this.nationalId = "",
    required this.phone,
    this.status = "Active",
    this.type = "Cash",
    this.notes = "",
    this.invoiceIds = const [],
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      tradeName: json['trade_name'],
      personInCharge: json['person_in_charge'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      addressId: json['address_id'],
      regionId: json['region_id'],
      balance: json['balance'] ?? 0,
      commercialRegistration: json['commercial_registration'] ?? "",
      professionLicensePath: json['profession_license_path'] ?? "",
      nationalId: json['national_id'] ?? "",
      phone: json['phone'],
      status: json['status'] ?? "Active",
      type: json['type'] ?? "Cash",
      notes: json['notes'] ?? "",
      invoiceIds: List<int>.from(json['invoice_ids'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'trade_name': tradeName,
      'person_in_charge': personInCharge,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'address_id': addressId,
      'region_id': regionId,
      'balance': balance,
      'commercial_registration': commercialRegistration,
      'profession_license_path': professionLicensePath,
      'national_id': nationalId,
      'phone': phone,
      'status': status,
      'type': type,
      'notes': notes,
      'invoice_ids': invoiceIds,
    };
  }

  /// Copy With Method 🔥
  Client copyWith({
    int? id,
    String? tradeName,
    String? personInCharge,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? addressId,
    int? regionId,
    int? balance,
    String? commercialRegistration,
    String? professionLicensePath,
    String? nationalId,
    String? phone,
    String? status,
    String? type,
    String? notes,
    List<int>? assignedSalesmenIds,
    List<int>? invoiceIds,
  }) {
    return Client(
      id: id ?? this.id,
      tradeName: tradeName ?? this.tradeName,
      personInCharge: personInCharge ?? this.personInCharge,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      addressId: addressId ?? this.addressId,
      regionId: regionId ?? this.regionId,
      balance: balance ?? this.balance,
      commercialRegistration: commercialRegistration ?? this.commercialRegistration,
      professionLicensePath: professionLicensePath ?? this.professionLicensePath,
      nationalId: nationalId ?? this.nationalId,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      type: type ?? this.type,
      notes: notes ?? this.notes,
      invoiceIds: invoiceIds ?? this.invoiceIds,
    );
  }
}