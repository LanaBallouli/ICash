class ClientSalesman {
  final int clientId;
  final int salesmanId;
  final DateTime? assignedAt;

  const ClientSalesman({
    required this.clientId,
    required this.salesmanId,
    this.assignedAt,
  });

  factory ClientSalesman.fromJson(Map<String, dynamic> json) {
    return ClientSalesman(
      clientId: json['client_id'],
      salesmanId: json['salesman_id'],
      assignedAt: DateTime.parse(json['assigned_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'client_id': clientId,
      'salesman_id': salesmanId,
      'assigned_at': assignedAt?.toIso8601String(),
    };
  }
}