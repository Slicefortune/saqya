class ModelGoogleResponse {
  dynamic businessStatus;
  Geometry? geometry;
  dynamic icon;
  dynamic iconBackgroundColor;
  dynamic iconMaskBaseUri;
  dynamic name;
  OpeningHours? openingHours;
  List<Photos>? photos;
  dynamic placeId;
  dynamic rating;
  dynamic reference;
  dynamic scope;
  List<String>? types;
  dynamic userRatingsTotal;
  dynamic vicinity;

  ModelGoogleResponse(
      {this.businessStatus,
      this.geometry,
      this.icon,
      this.iconBackgroundColor,
      this.iconMaskBaseUri,
      this.name,
      this.openingHours,
      this.photos,
      this.placeId,
      this.rating,
      this.reference,
      this.scope,
      this.types,
      this.userRatingsTotal,
      this.vicinity});

  ModelGoogleResponse.fromJson(Map<String, dynamic> json) {
    businessStatus = json['business_status'];
    geometry = json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null;
    icon = json['icon'];
    iconBackgroundColor = json['icon_background_color'];
    iconMaskBaseUri = json['icon_mask_base_uri'];
    name = json['name'];
    openingHours = json['opening_hours'] != null ? OpeningHours.fromJson(json['opening_hours']) : null;
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add(Photos.fromJson(v));
      });
    }
    placeId = json['place_id'];
    rating = json['rating'];
    reference = json['reference'];
    scope = json['scope'];
    types = json['types'].cast<String>();
    userRatingsTotal = json['user_ratings_total'];
    vicinity = json['vicinity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['business_status'] = businessStatus;
    if (geometry != null) {
      data['geometry'] = geometry!.toJson();
    }
    data['icon'] = icon;
    data['icon_background_color'] = iconBackgroundColor;
    data['icon_mask_base_uri'] = iconMaskBaseUri;
    data['name'] = name;
    if (openingHours != null) {
      data['opening_hours'] = openingHours!.toJson();
    }
    if (photos != null) {
      data['photos'] = photos!.map((v) => v.toJson()).toList();
    }
    data['place_id'] = placeId;
    data['rating'] = rating;
    data['reference'] = reference;
    data['scope'] = scope;
    data['types'] = types;
    data['user_ratings_total'] = userRatingsTotal;
    data['vicinity'] = vicinity;
    return data;
  }
}

class Geometry {
  Location? location;
  Viewport? viewport;

  Geometry({this.location, this.viewport});

  Geometry.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    viewport = json['viewport'] != null ? Viewport.fromJson(json['viewport']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (viewport != null) {
      data['viewport'] = viewport!.toJson();
    }
    return data;
  }
}

class Location {
  dynamic lat;
  dynamic lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

class Viewport {
  Location? northeast;
  Location? southwest;

  Viewport({this.northeast, this.southwest});

  Viewport.fromJson(Map<String, dynamic> json) {
    northeast = json['northeast'] != null ? Location.fromJson(json['northeast']) : null;
    southwest = json['southwest'] != null ? Location.fromJson(json['southwest']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (northeast != null) {
      data['northeast'] = northeast!.toJson();
    }
    if (southwest != null) {
      data['southwest'] = southwest!.toJson();
    }
    return data;
  }
}

class OpeningHours {
  bool? openNow;

  OpeningHours({this.openNow});

  OpeningHours.fromJson(Map<String, dynamic> json) {
    openNow = json['open_now'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['open_now'] = openNow;
    return data;
  }
}

class Photos {
  dynamic height;
  List<String>? htmlAttributions;
  dynamic photoReference;
  dynamic width;

  Photos({this.height, this.htmlAttributions, this.photoReference, this.width});

  Photos.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    htmlAttributions = json['html_attributions'].cast<String>();
    photoReference = json['photo_reference'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['height'] = height;
    data['html_attributions'] = htmlAttributions;
    data['photo_reference'] = photoReference;
    data['width'] = width;
    return data;
  }
}
