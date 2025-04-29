class Product {
  int? id;
  String? name;
  String? description;
  int? price;
  int? categoryId;
  String? unit;
  String? productNum;
  int? stockQuantity;
  int? reorderLimit;
  String? createdAt;
  String? updatedAt;
  double? discount;

  Product(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.categoryId,
      this.unit,
      this.productNum,
      this.stockQuantity,
      this.reorderLimit,
      this.createdAt,
      this.updatedAt,
      this.discount});

  Product.fromJson({required Map<dynamic, dynamic> json}) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    categoryId = json['category_id'];
    unit = json['unit'];
    productNum = json['product_num'];
    stockQuantity = json['stock_quantity'];
    reorderLimit = json['reorder_limit'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['category_id'] = this.categoryId;
    data['unit'] = this.unit;
    data['product_num'] = this.productNum;
    data['stock_quantity'] = this.stockQuantity;
    data['reorder_limit'] = this.reorderLimit;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['discount'] = this.discount;
    return data;
  }
}
