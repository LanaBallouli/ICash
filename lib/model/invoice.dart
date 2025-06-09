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
      type: json['type'],
      clientId: json['client_id'],
      issueDate: DateTime.parse(json['issue_date']),
      dueDate: DateTime.parse(json['due_date']),
      tax: json['tax']?.toDouble() ?? 0.0,
      taxNumber: json['tax_number'] ?? "",
      discount: json['discount']?.toDouble() ?? 0.0,
      status: json['status'] ?? "Pending",
      creationTime: DateTime.parse(json['creation_time']),
      notes: json['notes'] ?? "",
      userId: json['user_id'],
      total: json['total']?.toDouble() ?? 0.0,
    );
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

}