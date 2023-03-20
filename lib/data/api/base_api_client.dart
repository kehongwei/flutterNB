import 'dart:convert';

import 'package:get/get.dart';
import '../../utils/app_constants.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late Map<String, String>_mainHeaders;

  ApiClient({required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
    initClient();
  }

  void initClient(){
    timeout = const Duration(seconds: 30);
    token = AppConstants.TOKEN;
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> getData(String uri) async {
    try {
      print(uri);
      Response response = await get(uri);
      return response;
    } catch (e) {
      print('Error apiClient.getData');
      return Response(
        statusCode: 1,
        statusText: e.toString(),
      );
    }
  }

  Future<Response> postData(String uri, dynamic body) async {

    try {
      Response response = await post(uri,body,headers: _mainHeaders);
      print(response.statusCode);
      print(response.body);
      return response;
    } catch (e) {
      print(e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  dynamic encodeBody(dynamic body){
    _mainHeaders["Content-type"] = "application/x-www-form-urlencoded";
    return Uri(queryParameters: body).query;
  }

  void updateHeader(String token) {
    _mainHeaders["Content-type"] = "application/json; charset=UTF-8";
    _mainHeaders["Authorization"] = "Bearer $token";
  }


}
