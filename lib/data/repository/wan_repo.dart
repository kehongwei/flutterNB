import 'package:flutter/cupertino.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/signup_body_model.dart';
import '../api/food_api_client.dart';
import '../api/wan_api_client.dart';

class WanRepo {
  final WanApiClient apiClient;
  final SharedPreferences sharedPreferences;

  WanRepo({required this.apiClient,required this.sharedPreferences});

  Future<Response> getArticle(int page) async {

    return  apiClient.getData("${AppConstants.ARTICLE}$page/json");
  }


}


