import 'dart:convert';

ModelProductsList modelProductsListFromJson(String str) => ModelProductsList.fromJson(json.decode(str));
String modelProductsListToJson(ModelProductsList data) => json.encode(data.toJson());

class ModelProductsList {
  ModelProductsList({
    this.id,
    this.name,
    this.nameAr,
    this.image,
    this.size,
    this.price,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  ModelProductsList.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];

    image = json['image'];
    size = json['size'];
    price = json['price'];
    status = json['status'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  dynamic id;
  dynamic name;
  dynamic nameAr;

  dynamic image;
  dynamic size;
  dynamic price;
  double get priceDouble => double.tryParse(price.toString()) ?? 0;
  dynamic status;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['name_ar'] = nameAr;

    map['image'] = image;
    map['size'] = size;
    map['price'] = price;
    map['status'] = status;
    map['deleted_at'] = deletedAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
