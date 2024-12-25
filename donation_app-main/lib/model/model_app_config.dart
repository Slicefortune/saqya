import 'dart:convert';
ModelAppConfig modelAppConfigFromJson(String str) => ModelAppConfig.fromJson(json.decode(str));
String modelAppConfigToJson(ModelAppConfig data) => json.encode(data.toJson());
class ModelAppConfig {
  ModelAppConfig({
      this.baseUrls, 
      this.termsAndConditionsEn,
      this.privacyPolicyEn,
    this.termsAndConditionsAr,
    this.privacyPolicyAr,
    this.maintenanceMode,
      this.softwareVersion, 
      this.whatsapp, 
      this.mapApiServerKey,});

  ModelAppConfig.fromJson(dynamic json) {
    baseUrls = json['base_urls'] != null ? BaseUrls.fromJson(json['base_urls']) : null;
    termsAndConditionsEn = json['terms_condition_en'];
    privacyPolicyEn = json['terms_condition_en'];

    termsAndConditionsAr = json['terms_condition_ar'];
    privacyPolicyAr = json['terms_condition_ar'];

    maintenanceMode = json['maintenance_mode'];
    softwareVersion = json['software_version'];
    whatsapp = json['whatsapp'];
    mapApiServerKey = json['map_api_server_key'];
  }
  BaseUrls? baseUrls;
  dynamic termsAndConditionsEn;
  dynamic privacyPolicyEn;

  dynamic termsAndConditionsAr;
  dynamic privacyPolicyAr;
  dynamic maintenanceMode;
  dynamic softwareVersion;
  dynamic whatsapp;
  dynamic mapApiServerKey;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (baseUrls != null) {
      map['base_urls'] = baseUrls?.toJson();
    }
    map['terms_condition_en'] = termsAndConditionsEn;
    map['terms_condition_ar'] = termsAndConditionsAr;

    map['privacy_policy_en'] = privacyPolicyEn;
    map['privacy_policy_ar'] = privacyPolicyAr;

    map['maintenance_mode'] = maintenanceMode;
    map['software_version'] = softwareVersion;
    map['whatsapp'] = whatsapp;
    map['map_api_server_key'] = mapApiServerKey;
    return map;
  }

}

BaseUrls baseUrlsFromJson(String str) => BaseUrls.fromJson(json.decode(str));
String baseUrlsToJson(BaseUrls data) => json.encode(data.toJson());

class BaseUrls {
  BaseUrls({
      this.imageUrl,});

  BaseUrls.fromJson(dynamic json) {
    imageUrl = json['image_url'];
  }
  dynamic imageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image_url'] = imageUrl;
    return map;
  }

}