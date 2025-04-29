class CashClient {
  int? id;
  String? clientNumber;
  int? userId;
  String? tradeName;
  String? createdAt;
  int? createdBy;
  String? updatedAt;
  double? latitude;
  double? longitude;
  int? regionId;

  CashClient(
      {this.id,
        this.clientNumber,
        this.userId,
        this.tradeName,
        this.createdAt,
        this.createdBy,
        this.updatedAt,
        this.latitude,
        this.longitude,
        this.regionId});

  CashClient.fromJson({required Map<dynamic, dynamic> json}) {
    id = json['id'];
    clientNumber = json['client_number'];
    userId = json['user_id'];
    tradeName = json['trade_name'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    regionId = json['region_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_number'] = this.clientNumber;
    data['user_id'] = this.userId;
    data['trade_name'] = this.tradeName;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['region_id'] = this.regionId;
    return data;
  }
}