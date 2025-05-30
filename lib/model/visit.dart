class Visit {
  final int? id;
  final DateTime? visitDate;
  final String? notes;
  final DateTime? nextVisitTime;
  final int? userId;
  final int? clientId;

  Visit({
    this.id,
    this.userId,
    this.clientId,
    this.visitDate,
    this.notes,
    this.nextVisitTime,
  });


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