import 'package:test_sales/model/visit.dart';

class Invoice {
  int? id;
  String? invoiceNumber;
  String? type;
  ClientInfo? clientInfo;
  DateTime? issueDate;
  DateTime? dueDate;
  double? totalAmount;
  double? tax;
  String? taxNumber;
  double? discount;
  String? status;
  DateTime? creationTime;
  String? notes;
  int? userId;

  Invoice({
    this.id,
    this.invoiceNumber,
    this.type,
    this.clientInfo,
    this.issueDate,
    this.dueDate,
    this.totalAmount,
    this.tax,
    this.taxNumber,
    this.discount,
    this.status,
    this.creationTime,
    this.notes,
    this.userId
  });
}
class ClientInfo {
  int? id;
  String? name;
  int? phone;
  String? email;
  String? address;
  List<Visit>? visits;

  ClientInfo({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.address,
    this.visits
  });

}