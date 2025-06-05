class InvoiceItem {
  final int? id;
  final int invoiceId; // Foreign key referencing Invoice
  final int productId; // Foreign key referencing Product
  final int quantity;
  final double priceAtTime;
  final double discount;
  final double total;
  final DateTime createdAt;
  final DateTime updatedAt;

  InvoiceItem({
    this.id,
    required this.invoiceId,
    required this.productId,
    this.quantity = 1,
    this.priceAtTime = 0.0,
    this.discount = 0.0,
    this.total = 0.0,
    required this.createdAt,
    required this.updatedAt,
  });

  factory InvoiceItem.fromJson(Map<String, dynamic> json) {
    return InvoiceItem(
      id: json['id'],
      invoiceId: json['invoice_id'],
      productId: json['product_id'],
      quantity: json['quantity'] ?? 1,
      priceAtTime: json['price_at_time']?.toDouble() ?? 0.0,
      discount: json['discount']?.toDouble() ?? 0.0,
      total: json['total']?.toDouble() ?? 0.0,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'invoice_id': invoiceId,
      'product_id': productId,
      'quantity': quantity,
      'price_at_time': priceAtTime,
      'discount': discount,
      'total': total,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Helper method to calculate item total
  double calculateTotal({required double price, required int quantity, double discount = 0}) {
    return (price * quantity) - discount;
  }
}