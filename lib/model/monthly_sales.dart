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
}