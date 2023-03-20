import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../base/no_data_page.dart';
import '../../controllers/cart_controller.dart';
import '../../models/cart_model.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var getCartHistoryList = Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = {};

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!,
            (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!,
            () => 1);
      }
    }
    List<String> timeValue =
        cartItemsPerOrder.entries.map((e) => e.key).toList();
    

    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }
    //print(cartOrderTimeToList());

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }


    List<int> itemsPerOrder = cartItemsPerOrderToList();  // 3, 2, 3


    var listCounter = 0;

    Widget timeWidget(int index){
      var outputDate = DateTime.now().toString();
      if(index < getCartHistoryList.length){
        var original = DateFormat("yyyy-MM-dd HH:mm:ss").parse(timeValue[index]);
        var inputDate = DateTime.parse(original.toString());
        var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
        outputDate = outputFormat.format(inputDate);
      }
      return BigText(text: outputDate);

    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: Dimensions.dimen10 * 6,
        backgroundColor: AppColors.mainColor,
        title: BigText(text: 'Cart History',color: Colors.white,),
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: Dimensions.dimen20,
            ),
            child: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          GetBuilder<CartController>(builder: (cartController){
            return cartController.getCartHistoryList().isNotEmpty ? Expanded(
              child: Container(
                margin: EdgeInsets.only(
                    top: Dimensions.dimen20,
                    left: Dimensions.dimen20,
                    right: Dimensions.dimen20),
                child: ListView( // ListView.Builder
                  children: [
                    for (int i = 0; i < itemsPerOrder.length; i++)...[

                      Container(
                        margin: EdgeInsets.only(bottom: Dimensions.dimen20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            timeWidget(listCounter),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  direction: Axis.horizontal,
                                  children:
                                  List.generate(itemsPerOrder[i], (index) {
                                    print("in Cart_history. itemPerOrder[i] ${itemsPerOrder[i]}");
                                    if (listCounter < getCartHistoryList.length) {
                                      listCounter++;
                                    }
                                    return index <= 2
                                        ? Container(
                                      height: Dimensions.dimen1*80,
                                      width: Dimensions.dimen1*80,
                                      margin: EdgeInsets.only(right: Dimensions.dimen10),
                                      decoration: BoxDecoration(
                                        //color: Colors.red,
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.dimen15 / 2),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(AppConstants
                                                .IMAGE_UPLOADS_URL+ getCartHistoryList[listCounter - 1].img!)),
                                      ),
                                    )
                                        : Container();
                                  }),
                                ),
                                Container(
                                  height: Dimensions.dimen30 * 4,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SmallText(
                                        text: "Total",
                                        color: AppColors.titleColor,
                                      ),
                                      BigText(
                                        text: "${itemsPerOrder[i]} items",
                                        color: AppColors.titleColor,
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          List<String> ordertime = cartOrderTimeToList();
                                          //print("in cart_history. ordertime  ${ordertime[i]}");

                                          Map<int, CartModel> moreOrder = {};
                                          for (int j=0; j<getCartHistoryList.length; j++) {
                                            if (getCartHistoryList[j].time == ordertime[i].toString()) {
                                              moreOrder.putIfAbsent(getCartHistoryList[j].id!, () => getCartHistoryList[j]);
                                              // CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j]!)));
                                              print("in cart_history. Product info is ${jsonEncode(getCartHistoryList[j])}");
                                            }
                                          }
                                          Get.find<CartController>().items = moreOrder;
                                          Get.find<CartController>().addToCartList();
                                          Get.toNamed(RouteHelper.getCartPage());
                                        },
                                        child: Container(
                                          //padding: EdgeInsets.symmetric(horizontal: Dimensions.edgeInsets5, vertical: Dimensions.edgeInsets5),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.dimen15 / 3),
                                            border: Border.all(
                                                width: 1,
                                                color: AppColors.mainColor),
                                          ),
                                          child: SmallText(
                                            text: "one more",
                                            color: AppColors.mainColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                           ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ) : Center(child: Container(height: MediaQuery.of(context).size.height/1.5,child: const NoDataPage(text: "You didn't buy anything so far")));
          }),
        ],
      ),
    );
  }
}
