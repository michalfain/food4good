import 'dart:convert';
import 'dart:io' show Platform;

import 'package:device_info/device_info.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:food4good_app/dto/user_authentication.dart';
import 'package:food4good_app/dto/response.dart';
import 'package:food4good_app/utils/constants.dart';
import 'package:food4good_app/utils/logger.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BaseRestController {
  static const TAG = "BaseRestController";
  static Map<String, String> cachingValue = {};
  final USER_TOKEN_KEY = 'user_token';
  final ADMIN_TOKEN_KEY = 'admin_token_key';
  final USER_UDID = 'user_udid';
  final String url = Constants.URL_UAT; //this is UAT link
  //Constants.URL_TEST //this is tst link
  //final String url = "http://b84adbf0.ngrok.io/backend/";

  Future<ResponseDTO> executePost(String uri, dynamic params, {bool isAdmin: false}) async {
    Map<String, String> headers = await getHeaders(isAdmin);
    final response = await http.post(url + uri, headers: headers, body: jsonEncode(params));
    return handleResponse(response);
  }

  Future<ResponseDTO> executeGet(String uri, {bool isAdmin: false}) async {
    Map<String, String> headers = await getHeaders(isAdmin);
    final response = await http.get(url + uri, headers: headers);
    return handleResponse(response);
  }

  Future<ResponseDTO> executeDelete(String uri, {bool isAdmin: false}) async {
    Map<String, String> headers = await getHeaders(isAdmin);
    final response = await http.delete(url + uri, headers: headers);
    return handleResponse(response);
  }

  Future userLogin() async {
    Map<String, String> userData = await _getDeviceInfo();
    UserAuthentication user = new UserAuthentication(userData[USER_TOKEN_KEY], userData[USER_UDID]);
    print(user.toJson());
    final prefs = await SharedPreferences.getInstance();
    final response = await http.post(url + "login/user",
        headers: setBaseHeader({}), body: jsonEncode(user.toJson()));
    if (response.statusCode == 200) {
      var ut8Body = utf8.decode(response.bodyBytes);
      Map userResponse = json.decode(ut8Body);
      prefs.setString(USER_TOKEN_KEY, userResponse["token"]);
      return userResponse;
    } else {
      Crashlytics.instance.log('Failed to perform login of user');
    }
  }

  adminLogin() {}

  Future<Map<String, String>> getHeaders(bool isAdmin) async {
    Map<String, String> headers = {};
    final prefs = await SharedPreferences.getInstance();
    String token;
    if (isAdmin) {
      token = getAdminToken(prefs);
      Logger.log(TAG, message: "token from admin $token");
    } else {
      if (isNullEmpty(prefs.getString(USER_TOKEN_KEY)) || isNullEmpty(prefs.getString(USER_UDID))) {
        Map<String, String> data = await _getDeviceInfo();
        prefs.setString(USER_TOKEN_KEY, data[USER_TOKEN_KEY]);
        prefs.setString(USER_UDID, data[USER_UDID]);
      }
      token = prefs.getString(USER_TOKEN_KEY);
      Logger.log(TAG, message: "token from login $token");
    }

    headers["Authorization"] = "Bearer $token";
    return setBaseHeader(headers);
  }

  String getAdminToken(SharedPreferences prefs) {
    if (isNullEmpty(prefs.getString(ADMIN_TOKEN_KEY))) {
      prefs.setString(ADMIN_TOKEN_KEY, cachingValue[ADMIN_TOKEN_KEY]);
    }
    return prefs.getString(ADMIN_TOKEN_KEY);
  }

  Map<String, String> setBaseHeader(Map<String, String> headers) {
    headers["Content-Type"] = "application/json";
    Logger.log(TAG, message: "setBaseHeader: header: ${headers.toString()}");
    return headers;
  }

  Future<Map<String, String>> _getDeviceInfo() async {
    Map<String, String> dataMap = {};
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    FirebaseMessaging _fcm = FirebaseMessaging();
    String fcmToken = await _fcm.getToken();
    dataMap[USER_TOKEN_KEY] = fcmToken;
    if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      dataMap[USER_UDID] = iosDeviceInfo.identifierForVendor;
      return dataMap;
    }
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      dataMap[USER_UDID] = androidDeviceInfo.androidId;
      return dataMap;
    }
    dataMap[USER_UDID] = "unknownPlatform";
    Crashlytics.instance.log("unable to get platform");
    return dataMap;
  }

  bool isNullEmpty(Object o) => o == null || "" == o;

  ResponseDTO handleResponse(http.Response response) {
    ResponseDTO responseDTO;
    if (response.statusCode < 300) {
      var ut8Body = utf8.decode(response.bodyBytes);
      responseDTO = new ResponseDTO(json.decode(ut8Body), false, 0, "");
      Logger.log(TAG, message: "handleResponse: code: ${response.statusCode} jsonString: ${responseDTO.toJson().toString()}");
      return responseDTO;
    }
    Crashlytics.instance.log("unable to get data from server : error : ${response.statusCode}");
    if (response.statusCode < 500) {
      responseDTO = new ResponseDTO("", true, response.statusCode,
          "Failed to load Data. Error no.: " + response.statusCode.toString());
    } else {
      responseDTO = new ResponseDTO("", true, response.statusCode, "Failed to load Data");
    }
    Logger.log(TAG, message: "handleResponse: code: ${response.statusCode} jsonString: ${responseDTO.toJson().toString()}");
    return responseDTO;
  }
}
