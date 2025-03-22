class User {
  String? fullName;
  String? email;
  int? phone;
  String? password;
  String? role;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? regionId;
  int? routeId;

  User(
      {
        this.fullName,
        this.email,
        this.phone,
        this.password,
        this.role,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.regionId,
        this.routeId});

  User.fromJson(Map<dynamic, dynamic> json) {
    fullName = json['full_name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    role = json['role'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    regionId = json['region_id'];
    routeId = json['route_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['role'] = this.role;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['region_id'] = this.regionId;
    data['route_id'] = this.routeId;
    return data;
  }
}