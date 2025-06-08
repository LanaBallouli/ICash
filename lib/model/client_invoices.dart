class ClientInvoice {
  final int clientId;
  final int invoiceId;
  final DateTime? assignedAt;

  const ClientInvoice({
    required this.clientId,
    required this.invoiceId,
    this.assignedAt,
  });

  factory ClientInvoice.fromJson(Map<String, dynamic> json) {
    return ClientInvoice(
      clientId: json['client_id'] ?? json['clientId'],
      invoiceId: json['invoice_id'] ?? json['invoiceId'],
      assignedAt: DateTime.parse(json['assigned_at'] ?? json['assignedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'client_id': clientId,
      'invoice_id': invoiceId,
      'assigned_at': assignedAt?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'ClientInvoice(clientId: $clientId, invoiceId: $invoiceId, assignedAt: $assignedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ClientInvoice &&
        other.clientId == clientId &&
        other.invoiceId == invoiceId;
  }

  @override
  int get hashCode => clientId.hashCode ^ invoiceId.hashCode;
}