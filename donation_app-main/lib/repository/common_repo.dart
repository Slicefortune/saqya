import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/helper.dart';
import 'dart:math' as math;

String deviceId = "";

enum ApiMethods {
  get,
  post,
  put,
  delete,
  patch,
  head,
  options,
}

class Repositories {
  static String userInfo = 'user_info';
  // Future assignDeviceToken() async {
  //   try {
  //     await ClientInformation.fetch().then((value) {
  //       deviceId = value.deviceId.toString();
  //     });
  //   } on PlatformException {
  //     log('Failed to get client information');
  //   }
  // }

  // static Future<LoginModel?> getUserInfo() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   if (preferences.getString(userInfo) != null) {
  //     return LoginModel.fromJson(jsonDecode(preferences.getString(userInfo)!));
  //   } else {
  //     return null;
  //   }
  // }

  static Future removeUserInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString(userInfo) != null) {
      preferences.remove(userInfo);
      // return LoginModel.fromJson(jsonDecode(preferences.getString(userInfo)!));
    }
  }

  static Future<String?> getFromLocal(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key);
  }

  static Future<Map<String, String>> get getHeaders async {
    // final model = await getUserInfo();
    final Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      // if (model?.authToken != null) HttpHeaders.authorizationHeader: 'Bearer ${model!.authToken}'
    };
    return headers;
  }

  Future _saveResponseToLocal({required String url, required String res}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(url, res);
  }

  Future<dynamic> postApi({
    BuildContext? context,
    required String url,
    // bool? showLoader = false,
    bool? showMap = false,
    bool? showResponse = true,
    bool? saveToLocal = false,
    Map<String, dynamic>? mapData,
  }) async {
    mapData ??= {};
    OverlayEntry loader = Helper.overlayLoader(
      context: context
    );
    if (context != null) {
      Overlay.of(context).insert(loader);
    }

    try {
      final Map<String, String> headers = await getHeaders;

      if (kDebugMode) {
        log("API Url.....  $url");
        log("API mapData.....  $mapData");
        log("API mapData Encoded.....  ${jsonEncode(mapData)}");
        log("API headers.....  $headers");
      }
      http.Response response = await http.post(Uri.parse(url), body: jsonEncode(mapData), headers: headers);

      if (kDebugMode) {
        if (showResponse == true) {
          log("API Response Url........  $url");
          log("API Response response.body........  ${response.body}");
          log("API Response mapData........  $mapData");
          log("API Response Status Code........  ${response.statusCode}");
          log("API Response Reason Phrase........  ${response.reasonPhrase}");
        }
      }

      Helper.hideLoader(loader);

      if (response.statusCode == 200 ||
          response.statusCode == 404 ||
          response.statusCode == 400 ||
          response.statusCode == 202 ||
          response.statusCode == 201) {
        // if (saveToLocal == true) {
        //   Uri uri = Uri.parse(url).replace(queryParameters: mapData);
        //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        //   sharedPreferences.setString(uri.toString(), response.body);
        // }
        if (saveToLocal == true) {
          Map<String, String> queryParameters = {};
          mapData.forEach((key, value) {
            queryParameters[key] = value.toString();
          });
          Uri uri = Uri.parse(url).replace(queryParameters: queryParameters);
          await _saveResponseToLocal(url: uri.toString(), res: response.body);
        }
        return response.body;
      } else if (response.statusCode == 401) {
        logOutUser();
        throw Exception(response.body);
      } else {
        if (kDebugMode) {
          showToast(response.body);
        } else {
          showToast("Something went wrong");
        }
        throw Exception(response.body);
      }
    } on SocketException catch (e) {
      Helper.hideLoader(loader);
      showToast("No Internet Access");
      throw Exception(e);
    } catch (e) {
      Helper.hideLoader(loader);
      throw Exception(e);
    }
  }

  Future<dynamic> getApi({
    BuildContext? context,
    required String url,
    bool? showMap = true,
    bool? showResponse = true,
    bool? returnResponse = false,
    bool? saveToLocal = false,
    Map<String, dynamic>? mapData,
  }) async {
    OverlayEntry loader = Helper.overlayLoader(
      context: context
    );
    if (context != null) {
      Overlay.of(context).insert(loader);
    }

    try {
      final Map<String, String> headers = await getHeaders;
      mapData ??= {};

      if (kDebugMode) {
        log("API Url.....  $url");
        log("API headers.....  $headers");
        log("API headers.....  $mapData");
      }

      var request = http.Request('GET', Uri.parse(url));
      request.body = jsonEncode(mapData);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      String res = await response.stream.bytesToString();

      if (kDebugMode) {
        if (showResponse == true) {
          log("API Url.....  $url");
          log("API Response........  $res");
          log("API Response Status Code........  ${response.statusCode}");
          log("API Response Reason Phrase........  ${response.reasonPhrase}");
        }
      }

      Helper.hideLoader(loader);
      if (returnResponse!) {
        return response;
      } else {
        if (response.statusCode == 200 || response.statusCode == 400 || response.statusCode == 404) {
          if (saveToLocal == true) {
            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
            sharedPreferences.setString(url, res);
          }
          return res;
        } else if (response.statusCode == 401) {
          logOutUser();
        } else {
          if (kDebugMode) {
            showToast(res);
          } else {
            showToast("Something went wrong");
          }
          throw Exception(response.statusCode);
        }
      }
    } on SocketException {
      Helper.hideLoader(loader);
      showToast("No Internet Access");
      throw Exception("No Internet Access");
    } catch (e) {
      Helper.hideLoader(loader);
      // showToast(e.toString());
      throw Exception(e);
    }
  }

  Future<dynamic> multiPartApi(
      {required mapData,
      required Map<String, File> images,
      BuildContext? context,
      required String url,
      }) async {
    OverlayEntry loader = Helper.overlayLoader(
      context: context
    );
    if (context != null) {
      Overlay.of(context).insert(loader);
    }

    try {
      final Map<String, String> headers = await getHeaders;
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.headers.addAll(headers);

      request.fields.addAll(mapData);
      for (var item in images.entries) {
        if (item.value.existsSync()) {
          request.files.add(await _multipartFile(item.key.toString(), item.value));
        }
      }
      if (kDebugMode) {
        log(url);
        log(request.headers.toString());
        log(request.fields.toString());
        log(request.files.map((e) => e.filename).toList().toString());
      }

      final response = await request.send();
      String value = await response.stream.bytesToString();
      log(value);
      Helper.hideLoader(loader);
      if (response.statusCode == 200) {
        return value;
      } else if (response.statusCode == 401) {
        logOutUser();
        throw Exception(value);
      } else {
        if (kDebugMode) {
          showToast(value);
        } else {
          showToast("Something went wrong");
        }
        Helper.hideLoader(loader);
        throw Exception(value);
      }
    } on SocketException catch (e) {
      Helper.hideLoader(loader);
      showToast("No Internet Access");
      throw Exception(e);
    } catch (e) {
      Helper.hideLoader(loader);
      if (kDebugMode) {
        showToast("Something went wrong.....${e.toString()}");
      } else {
        showToast("Something went wrong......");
      }
      throw Exception(e);
    }
  }

  Future<http.MultipartFile> _multipartFile(String? fieldName, File file1) async {
    return http.MultipartFile(
      fieldName ?? 'file',
      http.ByteStream(Stream.castFrom(file1.openRead())),
      await file1.length(),
      filename: file1.path.split('/').last,
    );
  }

  static Future<void> logOutUser() async {
    return;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    showToast("Access denied");
  }

  String? _apiUrl;
  ApiMethods? _apiMethod;
  Map<String, String>? _apiMapData;
  Map<String, File>? _apiFiles;
  Function(int bytes, int totalBytes)? _apiProgress;
  Function(http.StreamedResponse)? _getCompleteRequest;
  BuildContext? _buildContext;
  Color? _loaderColor;
  bool _saveToLocal = false;
  bool _addHeaders = true;
  bool _logs = kDebugMode ? true : false;

  Repositories addUrl(String url) {
    _apiUrl = url;
    return this;
  }

  Repositories setMethod({required ApiMethods method}) {
    _apiMethod = method;
    return this;
  }

  Repositories setMapData(Map<String, String>? map) {
    _apiMapData = map;
    return this;
  }

  Repositories setFiles(Map<String, File>? map) {
    _apiFiles = map;
    return this;
  }

  Repositories getProgress({required Function(int bytes, int totalBytes) apiProgress}) {
    _apiProgress = apiProgress;
    return this;
  }

  Repositories setLoader({required BuildContext context, Color? color}) {
    _buildContext = context;
    _loaderColor = color;
    return this;
  }

  Repositories saveToLocal(bool v) {
    _saveToLocal = v;
    return this;
  }

  Repositories setAddHeaders(bool v) {
    _addHeaders = v;
    return this;
  }

  Repositories setLogs(bool v) {
    _logs = v;
    return this;
  }

  Repositories getWholeResponse({required Function(http.StreamedResponse response) request}) {
    _getCompleteRequest = request;
    return this;
  }

  Future<dynamic> getResponse() async {
    if (_apiUrl == null) {
      throw Exception("Url not set");
    }
    if (_apiMethod == null) {
      throw Exception("Method not set");
    }
    OverlayEntry loader = Helper.overlayLoader(color: _loaderColor, context: _buildContext);
    if (_buildContext != null && _buildContext!.mounted) {
      Overlay.of(_buildContext!).insert(loader);
      FocusManager.instance.primaryFocus!.unfocus();
    }

    // ModelLoginResponse? model = await getLoginDetails();

    try {
      final Map<String, String> headers = await getHeaders;

      var request = CloseableMultipartRequest(_apiMethod!.name.toUpperCase(), Uri.parse(_apiUrl!),
          onProgress: (int bytes, int totalBytes) {
        if (_apiProgress != null) {
          _apiProgress!(bytes, totalBytes);
        }
      });
      // http.MultipartRequest request = http.MultipartRequest('GET', Uri.parse('{{base_url}}/api/add-update-category'));
      if (_apiMapData != null) {
        request.fields.addAll(_apiMapData!);
      }
      if (_addHeaders) {
        request.headers.addAll(headers);
      }
      if (_apiFiles != null) {
        for (var item in _apiFiles!.entries) {
          if (item.value.existsSync()) {
            request.files.add(await _multipartFile(item.key.toString(), item.value));
          }
        }
      }

      if (_logs) {
        log("_apiUrl.....     ${_apiUrl!}");
        log("headers.....     ${request.headers}");
        log("fields.....     ${request.fields}");
        log(request.files.map((e) => e.filename).toList().toString());
      }

      http.StreamedResponse response = await request.send();
      String value = await response.stream.bytesToString();
      if (_logs) {
        log("_apiUrl.....     ${_apiUrl!}");
        log("headers.....     ${request.headers}");
        log("fields.....     ${request.fields}");
        log("response.....     $value");
        log(request.files.map((e) => e.filename).toList().toString());
      }
      Helper.hideLoader(loader);

      if (response.statusCode == 200 || response.statusCode == 404 || response.statusCode == 400) {
        if (_saveToLocal == true && response.statusCode == 200) {
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          final httpUrl = Uri.parse(_apiUrl!).replace(queryParameters: _apiMapData);
          log("Saved Data Url.......    $httpUrl");

          sharedPreferences.setString(httpUrl.toString(), value);
        }
        if (_getCompleteRequest != null) {
          _getCompleteRequest!(response);
        }
        // if (withStatus != null) {
        //   withStatus(response.statusCode, value);
        // }
        return value;
      } else if (response.statusCode == 401) {
        logOutUser();
        throw Exception(value);
      } else {
        showToast(value);
        throw Exception(value);
      }
    } on SocketException catch (e) {
      Helper.hideLoader(loader);
      showToast("No Internet Access");
      throw Exception(e);
    } catch (e) {
      Helper.hideLoader(loader);
      if (kDebugMode) {
        showToast("Something went wrong.....${e.toString().substring(0, math.min(e.toString().length, 50))}");
      } else {
        showToast("Something went wrong......");
      }
      throw Exception(e);
    }
  }
}

class CloseableMultipartRequest extends http.MultipartRequest {
  http.Client client = http.Client();

  CloseableMultipartRequest(
    super.method,
    super.uri, {
    required this.onProgress,
  });

  void close() => client.close();

  @override
  Future<http.StreamedResponse> send() async {
    try {
      var response = await client.send(this);
      var stream = onDone(response.stream, client.close);
      return http.StreamedResponse(
        http.ByteStream(stream),
        response.statusCode,
        contentLength: response.contentLength,
        request: response.request,
        headers: response.headers,
        isRedirect: response.isRedirect,
        persistentConnection: response.persistentConnection,
        reasonPhrase: response.reasonPhrase,
      );
    } catch (_) {
      client.close();
      rethrow;
    }
  }

  final void Function(int bytes, int totalBytes) onProgress;

  @override
  http.ByteStream finalize() {
    final byteStream = super.finalize();
    // if (onProgress == null) return byteStream;

    final total = contentLength;
    int bytes = 0;

    final t = StreamTransformer.fromHandlers(
      handleData: (List<int> data, EventSink<List<int>> sink) {
        bytes += data.length;
        onProgress(bytes, total);
        if (total >= bytes) {
          sink.add(data);
        }
      },
    );
    final stream = byteStream.transform(t);
    return http.ByteStream(stream);
  }

  Stream<T> onDone<T>(Stream<T> stream, void Function() onDone) =>
      stream.transform(StreamTransformer.fromHandlers(handleDone: (sink) {
        sink.close();
        onDone();
      }));
}
