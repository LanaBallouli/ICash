class Product {
  int? id;
  String? name;
  String? description;
  double? price;
  int? categoryId;
  String? unit;
  String? productNum;
  int? stockQuantity;
  DateTime? createdAt;
  DateTime? updatedAt;
  double? discount;
  int? quantitySold;

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.categoryId,
    this.unit,
    this.productNum,
    this.stockQuantity = 0,
    this.createdAt,
    this.updatedAt,
    this.discount = 0.0,
    this.quantitySold,
  });

  double get totalRevenue {
    final safePrice = price ?? 0.0;
    final safeQuantitySold = quantitySold ?? 0;
    return safePrice * safeQuantitySold;
  }

  /// Factory constructor to create a `Product` object from JSON.
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num?)?.toDouble(),
      categoryId: json['category_id'],
      unit: json['unit'],
      productNum: json['product_num'],
      stockQuantity: json['stock_quantity'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      discount: (json['discount'] as num?)?.toDouble(),
      quantitySold: json['quantity_sold'],
    );
  }

  /// Converts the `Product` object to JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category_id': categoryId,
      'unit': unit,
      'product_num': productNum,
      'stock_quantity': stockQuantity,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'discount': discount,
      'quantity_sold': quantitySold,
    };
  }

  /// Creates a copy of the `Product` object with updated values.
  Product copyWith({
    int? id,
    String? name,
    String? description,
    double? price,
    int? categoryId,
    String? unit,
    String? productNum,
    int? stockQuantity,
    DateTime? createdAt,
    DateTime? updatedAt,
    double? discount,
    int? quantitySold,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      categoryId: categoryId ?? this.categoryId,
      unit: unit ?? this.unit,
      productNum: productNum ?? this.productNum,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      discount: discount ?? this.discount,
      quantitySold: quantitySold ?? this.quantitySold,
    );
  }

  /// Validates the `Product` object.
  void validate() {
    if (name == null || name!.isEmpty) {
      throw ArgumentError("Product name cannot be empty.");
    }
    if (price != null && price! < 0) {
      throw ArgumentError("Price cannot be negative.");
    }
    if (stockQuantity != null && stockQuantity! < 0) {
      throw ArgumentError("Stock quantity cannot be negative.");
    }
    if (discount != null && (discount! < 0 || discount! > 100)) {
      throw ArgumentError("Discount must be between 0 and 100.");
    }
  }
}