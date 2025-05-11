class Product {
  final int? id;
  final String? name;
  final String? description;
  final double? price;
  final String? category;
  final String? brand;
  final int? quantity;
  final bool? isAvailable;
  final String? imageUrl;
  final List<String>? images;
  final double? discount;
  final double? taxRate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? supplierId;

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.category,
    this.brand,
    this.quantity,
    this.isAvailable,
    this.imageUrl,
    this.images,
    this.discount,
    this.taxRate = 0.0,
    this.createdAt,
    this.updatedAt,
    this.supplierId,
  });

}