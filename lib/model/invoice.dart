class Invoice {
  int? invoiceNumber;
  String? type;
  int? clientId;
  int? userId;
  String? issueDate;
  String? dueDate;
  int? totalAmount;
  int? tax;
  int? discount;
  String? status;
  String? createdAt;
  String? taxNumber;
  String? notes;

  Invoice(
      {
        this.invoiceNumber,
        this.type,
        this.clientId,
        this.userId,
        this.issueDate,
        this.dueDate,
        this.totalAmount,
        this.tax,
        this.discount,
        this.status,
        this.createdAt,
        this.taxNumber,
        this.notes});

  Invoice.fromJson(Map<dynamic, dynamic> json) {
    invoiceNumber = json['invoice_number'];
    type = json['type'];
    clientId = json['client_id'];
    userId = json['user_id'];
    issueDate = json['issue_date'];
    dueDate = json['due_date'];
    totalAmount = json['total_amount'];
    tax = json['tax'];
    discount = json['discount'];
    status = json['status'];
    createdAt = json['created_at'];
    taxNumber = json['tax_number'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invoice_number'] = this.invoiceNumber;
    data['type'] = this.type;
    data['client_id'] = this.clientId;
    data['user_id'] = this.userId;
    data['issue_date'] = this.issueDate;
    data['due_date'] = this.dueDate;
    data['total_amount'] = this.totalAmount;
    data['tax'] = this.tax;
    data['discount'] = this.discount;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['tax_number'] = this.taxNumber;
    data['notes'] = this.notes;
    return data;
  }
}