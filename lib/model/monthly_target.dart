class MonthlyTarget {
  int? targetAmount;
  int? progress;
  int? createdBy;
  String? createdAt;
  String? startDate;
  String? endDate;


  MonthlyTarget(
      {
        this.targetAmount,
        this.progress,
        this.createdBy,
        this.createdAt,
        this.startDate,
        this.endDate});

  MonthlyTarget.fromJson(Map<dynamic, dynamic> json) {
    targetAmount = json['target_amount'];
    progress = json['progress'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['target_amount'] = targetAmount;
    data['progress'] = progress;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    return data;
  }
}