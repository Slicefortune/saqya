import 'dart:convert';

ModelBannersList modelBannersListFromJson(String str) => ModelBannersList.fromJson(json.decode(str));
String modelBannersListToJson(ModelBannersList data) => json.encode(data.toJson());

class ModelBannersList {
  ModelBannersList({
    this.id,
    this.image,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  ModelBannersList.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
    status = json['status'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  dynamic id;
  dynamic image;
  dynamic status;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    map['status'] = status;
    map['deleted_at'] = deletedAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
