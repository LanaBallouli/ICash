class Visit {
  final int id;
  final DateTime visitDate;
  final String notes;
  final DateTime? nextVisitTime;
  final int userId; // Foreign key referencing SalesMan
  final int clientId; // Foreign key referencing Client

  Visit({
    required this.id,
    required this.visitDate,
    this.notes = "",
    this.nextVisitTime,
    required this.userId,
    required this.clientId,
  });

  factory Visit.fromJson(Map<String, dynamic> json) {
    return Visit(
      id: json['id'],
      visitDate: DateTime.parse(json['visit_date']),
      notes: json['notes'] ?? "",
      nextVisitTime: json['next_visit_time'] != null ? DateTime.parse(json['next_visit_time']) : null,
      userId: json['user_id'],
      clientId: json['client_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'visit_date': visitDate.toIso8601String(),
      'notes': notes,
      'next_visit_time': nextVisitTime?.toIso8601String(),
      'user_id': userId,
      'client_id': clientId,
    };
  }
}