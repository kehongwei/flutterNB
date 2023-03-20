import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repository/cart_repo.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';
import '../utils/colors.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  set items(Map<int, CartModel> value) {
    _items = {};
    _items = value;
  }

  List<CartModel> storageItems = [];

  void deleteProduct(ProductModel product){
    _items.remove(product.id);
    cartRepo.addToCartList(getItems);
    update();
  }

  void addItem(ProductModel product, int quantity) {
    var totalQuantity = 0;
    if (_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        // value is ProductModel that already added before
        // just update the quantity
        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity! + quantity,
          isExists: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });

      if (totalQuantity <= 0) {
        _items.remove(product.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            isExists: true,
            time: DateTime.now().toString(),
            product: product,
          );
        });
      } else {
        Get.snackbar(
          "Empty Quantity",
          "You can't add empty quantity !",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
        );
      }
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  bool isExistsInCart(ProductModel product) {
    bool isExists = false;
    if (_items.containsKey(product.id)) {
      isExists = true;
    }

    return isExists;
  }

  int? getQuantity(ProductModel product) {
    int? quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity;
        }
      });
    }

    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;

    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalAmount {
    var _totalAmount = 0;

    _items.forEach((key, value) {
      _totalAmount += value.price! * value.quantity!;
    });
    return _totalAmount;
  }

  List<CartModel> getCartData(){
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items){
    storageItems  = items;
    for(int i = 0;i < storageItems.length ; i++){
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }

  }

  void addToHistory() {
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear() {
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList() {
    return cartRepo.getCartHistoryList();
  }

  void addToCartList() {
    cartRepo.addToCartList(getItems);
    update();
  }

  void removeCart() {
    cartRepo.removeCart();
  }

  void removeCartHistory() {
    cartRepo.removeCartHistory();
  }

  void updateCart() {
    update();
  }

  void removeCartSharedPreference() {
    cartRepo.removeCartSharedPreference();
  }
}
