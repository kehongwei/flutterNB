
import 'package:food_delivery/models/user_bean.dart';
import 'package:food_delivery/models/wan_response.dart';
import 'package:get/get.dart';

import '../data/repository/auth_repo.dart';
import '../models/response_model.dart';
import '../models/signup_body_model.dart';

class AuthController extends GetxController implements GetxService {
   final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    _isLoading = true;
    update();
    late ResponseModel responseModel;
    Response response = await authRepo.registration(signUpBody);

    if (response.statusCode == 200 ) {
      // authRepo.saveUserToken(response.body["token"])
      responseModel = ResponseModel(true, response.statusText!);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }



  Future<WanResponse> login(String username, String password) async {

    _isLoading = true;
    update();
    Response response = await authRepo.login(username, password);
    var wanResponse = WanResponse.fromJson(response.body, (json) => UserBean.fromJson(json as Map<String, dynamic>));
    if(response.statusCode == 200){
      print("------${username}-----");
      saveUserNumberAndPassword(username,password);
    }
    _isLoading = false;
    update();
    return wanResponse;
  }

  void saveUserNumberAndPassword(String username, String password) {
    authRepo.saveUserNumberAndPassword(username, password);
  }


  bool userLoggedIn() {
    return authRepo.userLoggedIn();
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }



}
