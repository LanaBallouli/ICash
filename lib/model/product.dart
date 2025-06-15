class Product {
  final int? id;
  final String name;
  final String description;
  final double price;
  final String brand;
  final int quantity;
  final bool isAvailable;
  final String imageUrl;
  final double discount;
  final double taxRate;
  final double totalSales;
  final int unitsSold;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    this.brand = "",
    required this.quantity,
    this.isAvailable = true,
    this.imageUrl = "assets/images/product_default_image.png",
    this.discount = 0.0,
    this.taxRate = 0.0,
    this.totalSales = 0.0,
    this.unitsSold = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price']?.toDouble() ?? 0.0,
      brand: json['brand'] ?? "",
      quantity: json['quantity'] ?? 0,
      isAvailable: json['is_available'] ?? true,
      imageUrl: json['image_url'] ?? "assets/images/product_default_image.png",
      discount: json['discount']?.toDouble() ?? 0.0,
      taxRate: json['tax_rate']?.toDouble() ?? 0.0,
      totalSales: json['total_sales']?.toDouble() ?? 0.0,
      unitsSold: json['units_sold'] ?? 0,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'description': description,
      'price': price,
      'brand': brand,
      'quantity': quantity,
      'is_available': isAvailable,
      'image_url': imageUrl,
      'discount': discount,
      'tax_rate': taxRate,
      'total_sales': totalSales,
      'units_sold': unitsSold,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}