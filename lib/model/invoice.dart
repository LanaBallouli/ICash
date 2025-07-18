import 'package:intl/intl.dart';

class Invoice {
  final int? id;
  final String invoiceNumber;
  final String type;
  final int clientId; // Foreign key referencing Client
  final DateTime issueDate;
  final DateTime dueDate;
  final double tax;
  final String taxNumber;
  final double discount;
  final String status;
  final DateTime creationTime;
  final String notes;
  final int userId; // Foreign key referencing SalesMan
  final double total;

  Invoice({
    this.id,
    required this.invoiceNumber,
    required this.type,
    required this.clientId,
    required this.issueDate,
    required this.dueDate,
    this.tax = 0.0,
    this.taxNumber = "",
    this.discount = 0.0,
    this.status = "Pending",
    required this.creationTime,
    this.notes = "",
    required this.userId,
    this.total = 0.0,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'],
      invoiceNumber: json['invoice_number'],
      type: json['type'] ?? "Cash",
      clientId: json['client_id'],
      issueDate: safeParseDate(json['issue_date']), // ✅ Safe parsing
      dueDate: safeParseDate(json['due_date']),
      tax: json['tax']?.toDouble() ?? 0.0,
      taxNumber: json['tax_number'] ?? "",
      discount: json['discount']?.toDouble() ?? 0.0,
      status: json['status'] ?? "Pending",
      creationTime: safeParseDate(json['creation_time']),
      notes: json['notes'] ?? "",
      userId: json['user_id'],
      total: json['total']?.toDouble() ?? 0.0,
    );
  }

  static DateTime safeParseDate(dynamic date) {
    final now = DateTime.now();

    if (date == null) return now;

    try {
      if (date is String) {
        if (date.contains('T')) {
          return DateTime.parse(date); // ISO format
        } else {
          return DateFormat('yyyy-MM-dd HH:mm:ss').parse(date);
        }
      } else if (date is int) {
        return DateTime.fromMillisecondsSinceEpoch(date * 1000);
      }

      return now;
    } catch (e) {
      print("Error parsing date: $e");
      return now;
    }
  }
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'invoice_number': invoiceNumber,
      'type': type,
      'client_id': clientId,
      'issue_date': issueDate.toIso8601String(),
      'due_date': dueDate.toIso8601String(),
      'tax': tax,
      'tax_number': taxNumber,
      'discount': discount,
      'status': status,
      'creation_time': creationTime.toIso8601String(),
      'notes': notes,
      'user_id': userId,
      'total': total,
    };
  }


  Invoice copyWith({
    int? id,
    String? invoiceNumber,
    String? type,
    int? clientId,
    DateTime? issueDate,
    DateTime? dueDate,
    double? tax,
    String? taxNumber,
    double? discount,
    String? status,
    DateTime? creationTime,
    String? notes,
    int? userId,
    double? total,
  }) {
    return Invoice(
      id: id ?? this.id,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      type: type ?? this.type,
      clientId: clientId ?? this.clientId,
      issueDate: issueDate ?? this.issueDate,
      dueDate: dueDate ?? this.dueDate,
      tax: tax ?? this.tax,
      taxNumber: taxNumber ?? this.taxNumber,
      discount: discount ?? this.discount,
      status: status ?? this.status,
      creationTime: creationTime ?? this.creationTime,
      notes: notes ?? this.notes,
      userId: userId ?? this.userId,
      total: total ?? this.total,
    );
  }
}
