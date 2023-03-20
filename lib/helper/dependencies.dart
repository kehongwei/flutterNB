import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/home_controller.dart';
import 'package:food_delivery/controllers/wan_controller.dart';
import 'package:food_delivery/data/repository/wan_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/cart_controller.dart';
import '../controllers/popular_product_controller.dart';
import '../controllers/recommended_product_controller.dart';
import '../data/api/food_api_client.dart';
import '../data/api/wan_api_client.dart';
import '../data/repository/auth_repo.dart';
import '../data/repository/cart_repo.dart';
import '../data/repository/popular_product_repo.dart';
import '../data/repository/recommended_product_repo.dart';
import '../utils/app_constants.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  // Shared Preferences
  Get.lazyPut(() => sharedPreferences);

  // ApiClient
  Get.lazyPut(() => FoodApiClient(appBaseUrl: AppConstants.FOOD_BASE_URL));
  Get.lazyPut(() => WanApiClient(appBaseUrl: AppConstants.WAN_BASE_URL));

  // Repos
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(),sharedPreferences: Get.find()));
  Get.lazyPut(() => WanRepo(apiClient: Get.find(),sharedPreferences: Get.find()));
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

  // Controller
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => WanController(wanRepo: Get.find()));
  Get.lazyPut(() => HomeController());
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
