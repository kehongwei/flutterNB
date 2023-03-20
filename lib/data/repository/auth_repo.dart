import 'package:flutter/cupertino.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/signup_body_model.dart';
import '../api/food_api_client.dart';
import '../api/wan_api_client.dart';

class AuthRepo {
  final WanApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient,required this.sharedPreferences});

  Future<Response> registration(SignUpBody signUpBody) async {

    return await apiClient.postData(AppConstants.REGSTRATION_URI,apiClient.encodeBody(signUpBody.toJson()));
  }

  Future<Response> login(String username, String password) async {

    return await apiClient.postData(AppConstants.LOGIN_URI, apiClient.encodeBody({
      "username" : username,
      "password" : password
    }));
  }

  Future<bool> saveUserToken(String token) async {

    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  bool userLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.PHONE);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "NONE";
  }



  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.PHONE, number);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    } catch (e) {
        throw e;
    }
  }
  bool clearSharedData() {
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.PASSWORD);
    sharedPreferences.remove(AppConstants.PHONE);
    apiClient.token = "";
    apiClient.updateHeader("");
    return true;

  }


}


