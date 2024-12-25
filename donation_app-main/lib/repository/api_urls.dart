class ApiUrls {
  // https://alarisha.coachbetics.com/api/products
  // https://alarisha.coachbetics.com/api/banners
  // https://alarisha.coachbetics.com/api/donation (post)

  // static const String baseUrl = "https://alarisha.coachbetics.com/";
  static const String baseUrl = "https://donation.fitgate.live/";

  // static const String baseUrl = "http://127.0.0.1:8000/";

  static const String baseAPIUrl = "${baseUrl}api/";

  static const String productsUrl = "${baseAPIUrl}products";
  static const String bannersUrl = "${baseAPIUrl}banners";
  static const String donationUrl = "${baseAPIUrl}donation";
  static const String configUrl = "${baseAPIUrl}config";
}
