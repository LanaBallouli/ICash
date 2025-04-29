class ProductCategory {
  int? id;
  String? name;
  String? createdAt;

  ProductCategory({this.id, this.name, this.createdAt});

  ProductCategory.fromJson({required Map<dynamic, dynamic> json}) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    return data;
  }
}