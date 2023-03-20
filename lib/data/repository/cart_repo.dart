import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';
import '../../utils/app_constants.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  // Shared Preference save data as a String
  List<String> cart = [];
  List<String> cartHistory = [];
  void addToCartList(List<CartModel> cartList) {
    cart = [];
    var time = DateTime.now().toString();


    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });



    // cartList.forEach((element) => cart.add(jsonEncode(element)));

    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);

    getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    List<CartModel> cartList = [];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      print("inside getCartList :  " + carts.toString());
    }

    carts.forEach((element) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    });

    /**
     carts.forEach((element) => CartModel.fromJson(jsonDecode(element)));
     */

    return cartList;
  }

  void addToCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    for (int i=0; i<cart.length; i++) {
      print("in Cart_repo. history list ${cart[i]}");
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
    print("The length of history list is ${getCartHistoryList().length.toString()}");
    for (CartModel i in getCartHistoryList()) {
      print("The time for the order is ${i.time}");
    }
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      //cartHistory = [];
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    List<CartModel> cartListHistory = [];
    for (String st in cartHistory) {
      cartListHistory.add(CartModel.fromJson(jsonDecode(st)));
    }
    //print("in Cart_repo. cartListHistory is ${cartListHistory.toString()}");
    return cartListHistory;
  }

  // Cart History 를 전부 지운다.
  void removeCartHistory() {
    cartHistory.clear();
    sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
  }

  void removeCartSharedPreference() {
    sharedPreferences.remove(AppConstants.CART_LIST);
    sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
  }
}
