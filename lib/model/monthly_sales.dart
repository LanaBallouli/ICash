class MonthlySales {
  int? id;
  int? userId;
  double? totalSales;
  DateTime? startDate;
  DateTime? endDate;

  MonthlySales({
    this.id,
    this.userId,
    this.totalSales = 0.0,
    this.startDate,
    this.endDate,
  });

  /// Factory constructor to create a `MonthlySales` object from JSON.
  factory MonthlySales.fromJson(Map<String, dynamic> json) {
    return MonthlySales(
      id: json['id'],
      userId: json['user_id'],
      totalSales: (json['total_sales'] as num?)?.toDouble(),
      startDate: json['start_date'] != null ? DateTime.parse(json['start_date']) : null,
      endDate: json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
    );
  }

  /// Converts the `MonthlySales` object to JSON.
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'user_id': userId,
      'total_sales': totalSales,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
    };
  }

  /// Creates a copy of the `MonthlySales` object with updated values.
  MonthlySales copyWith({
    int? id,
    int? userId,
    double? totalSales,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return MonthlySales(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      totalSales: totalSales ?? this.totalSales,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  /// Validates the `MonthlySales` object.
  void validate() {
    if (startDate == null) {
      throw ArgumentError("Start date cannot be null.");
    }
    if (endDate == null) {
      throw ArgumentError("End date cannot be null.");
    }
    if (endDate!.isBefore(startDate!)) {
      throw ArgumentError("End date cannot be before the start date.");
    }
    if (totalSales != null && totalSales! < 0) {
      throw ArgumentError("Total sales cannot be negative.");
    }
  }
}