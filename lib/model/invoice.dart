import 'package:test_sales/model/client.dart';
import 'package:test_sales/model/product.dart';
import 'package:test_sales/model/users.dart';

class Invoice {
  int? id;
  String? invoiceNumber;
  String? type;
  Client? clientId;
  DateTime? issueDate;
  DateTime? dueDate;
  double? totalAmount;
  double? tax;
  String? taxNumber;
  double? discount;
  String? status;
  DateTime? creationTime;
  String? notes;
  Users? userId;
  List<Product>? products;

  Invoice({
    this.id,
    this.invoiceNumber,
    this.type,
    this.clientId,
    this.issueDate,
    this.dueDate,
    this.tax,
    this.taxNumber,
    this.discount,
    this.status,
    this.creationTime,
    this.notes,
    this.userId,
    this.products,
  });

  double calculateTotalAmount() {
    if (products == null || products!.isEmpty) {
      return 0.0;
    }
    final subtotal = products!.fold(0.0, (sum, product) => sum + (product.price ?? 0.0));
    final totalAfterTax = subtotal + (tax ?? 0.0);
    final totalAfterDiscount = totalAfterTax - (discount ?? 0.0);
    return totalAfterDiscount > 0 ? totalAfterDiscount : 0.0;
  }

  /// Factory constructor to create an `Invoice` object from JSON.
  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'],
      invoiceNumber: json['invoice_number'],
      type: json['type'],
      clientId: json['client'] != null ? Client.fromJson(json['client']) : null,
      issueDate: json['issue_date'] != null ? DateTime.parse(json['issue_date']) : null,
      dueDate: json['due_date'] != null ? DateTime.parse(json['due_date']) : null,
      tax: (json['tax'] as num?)?.toDouble(),
      taxNumber: json['tax_number'],
      discount: (json['discount'] as num?)?.toDouble(),
      status: json['status'],
      creationTime: json['creation_time'] != null ? DateTime.parse(json['creation_time']) : null,
      notes: json['notes'],
      userId: json['user'] != null ? Users.fromJson(json['user']) : null,
      products: (json['products'] as List<dynamic>?)
          ?.map((productJson) => Product.fromJson(productJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'invoice_number': invoiceNumber,
      'type': type,
      'client': clientId?.toJson(),
      'issue_date': issueDate?.toIso8601String(),
      'due_date': dueDate?.toIso8601String(),
      'tax': tax,
      'tax_number': taxNumber,
      'discount': discount,
      'status': status,
      'creation_time': creationTime?.toIso8601String(),
      'notes': notes,
      'user': userId?.toJson(),
      'products': products?.map((product) => product.toJson()).toList(),
    };
  }
}