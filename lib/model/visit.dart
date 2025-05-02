class Visit {
  int? id;
  int? userId;
  int? clientId;
  DateTime? visitDate;
  String? notes;
  DateTime? nextVisitTime;

  Visit({
    this.id,
    this.userId,
    this.clientId,
    this.visitDate,
    this.notes,
    this.nextVisitTime,
  });

  factory Visit.fromJson(Map<String, dynamic> json) {
    return Visit(
      id: json['id'],
      userId: json['user_id'],
      clientId: json['client_id'],
      visitDate: json['visit_date'] != null ? DateTime.parse(json['visit_date']) : null,
      notes: json['notes'],
      nextVisitTime: json['next_visit_time'] != null ? DateTime.parse(json['next_visit_time']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'client_id': clientId,
      'visit_date': visitDate?.toIso8601String(),
      'notes': notes,
      'next_visit_time': nextVisitTime?.toIso8601String(),
    };
  }

  Visit copyWith({
    int? id,
    int? userId,
    int? clientId,
    DateTime? visitDate,
    String? notes,
    DateTime? nextVisitTime,
  }) {
    return Visit(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      clientId: clientId ?? this.clientId,
      visitDate: visitDate ?? this.visitDate,
      notes: notes ?? this.notes,
      nextVisitTime: nextVisitTime ?? this.nextVisitTime,
    );
  }

  void validate() {
    if (visitDate == null) {
      throw ArgumentError("Visit date cannot be null.");
    }
    if (nextVisitTime != null && nextVisitTime!.isBefore(visitDate!)) {
      throw ArgumentError("Next visit time cannot be before the visit date.");
    }
  }
}