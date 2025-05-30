import 'package:test_sales/model/product.dart';
import 'package:test_sales/model/salesman.dart';

class Invoice {
  int? id;
  String? invoiceNumber;
  String? type;
  int? clientId;
  DateTime? issueDate;
  double get totalAmount => calculateTotalAmount();
  DateTime? dueDate;
  double? tax;
  String? taxNumber;
  double? discount;
  String? status;
  DateTime? creationTime;
  String? notes;
  SalesMan? userId;
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

}