import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:food_delivery/base/no_data_page.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.dimen30*2,
            left: Dimensions.dimen20,
            right: Dimensions.dimen20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.dimen24,
                  ),
                ),
                SizedBox(width: Dimensions.dimen100),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.dimen24,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.dimen24,
                  ),
                ),
              ],
            ),
          ),
          GetBuilder<CartController>(
            builder: (cartController) {
              var cartList = cartController.getItems;

              return cartList.isNotEmpty ? Positioned(
                top: Dimensions.dimen100,
                right: Dimensions.dimen20,
                left: Dimensions.dimen20,
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.only(
                    top: Dimensions.dimen10,
                  ),
                  //color: Colors.redAccent,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                        itemCount: cartList.length,
                        itemBuilder: (_, index) {
                          return Slidable(
                            key:  ValueKey(index),

                            // The start action pane is the one at the left or the top side.
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),

                              // All actions are defined in the children parameter.
                              children:  [
                                // A SlidableAction can have an icon and/or a label.
                                SlidableAction(
                                  onPressed: (context) => cartController.deleteProduct(cartList[index].product!),
                                  backgroundColor: Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                                SlidableAction(
                                  onPressed: (context) => _onSlideClicked(1),
                                  backgroundColor: Color(0xFF21B7CA),
                                  foregroundColor: Colors.white,
                                  icon: Icons.share,
                                  label: 'Share',
                                ),
                              ],
                            ),

                            // The end action pane is the one at the right or the bottom side.
                            endActionPane:  ActionPane(
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) => _onSlideClicked(2),
                                  backgroundColor: Color(0xFF7BC043),
                                  foregroundColor: Colors.white,
                                  icon: Icons.vertical_align_top,
                                  label: '置顶',
                                ),
                              ],
                            ),

                            child: Container(
                              height: Dimensions.dimen100,
                              width: double.maxFinite,
                              // color: AppColors.mainColor,
                              margin: EdgeInsets.only(
                                bottom: Dimensions.dimen10,
                              ),
                              child: Row(
                                children: [
                                  // Food Picture
                                  GestureDetector(
                                    onTap: () {
                                      var popularIndex =
                                          Get.find<PopularProductController>()
                                              .popularProductList
                                              .indexOf(cartList[index].product!);

                                      if (popularIndex >= 0) {
                                        Get.toNamed(
                                            RouteHelper.getPopularFoodDetail(
                                                popularIndex, "cartpage"));
                                      } else {
                                        var recommendedIndex = Get.find<RecommendedProductController>().recommendedProductList
                                            .indexOf(cartList[index].product!);

                                        if(recommendedIndex < 0){
                                          Get.snackbar(
                                            "History Product",
                                            "product review is not available for history product !",
                                            backgroundColor: AppColors.mainColor,
                                            colorText: Colors.white,
                                          );
                                        }else{
                                          Get.toNamed(
                                              RouteHelper.getRecommendedFoodDetail(
                                                  recommendedIndex, "cartpage"));
                                        }


                                      }
                                    },
                                    child: Container(
                                      height: Dimensions.dimen100,
                                      width: Dimensions.dimen100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.dimen20),
                                        color: AppColors.mainBlackColor,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              AppConstants.IMAGE_UPLOADS_URL +
                                                  cartList[index].img!),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.dimen10),
                                  /** All Component besides Food Picture **/
                                  // Using Expanded to maximize horizontally because the parent is Row
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          BigText(
                                            text: cartList[index].name!,
                                            color: Colors.black54,
                                          ),
                                          SmallText(
                                            text: "Spicy",
                                            color: Colors.grey,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(
                                                  text:
                                                      "\$${cartList[index].price}",
                                                  color: Colors.red),
                                              Container(
                                                padding: EdgeInsets.only(
                                                  top: Dimensions.dimen15,
                                                  bottom: Dimensions.dimen15,
                                                  left: Dimensions.dimen20,
                                                  right: Dimensions.dimen20,
                                                ),
                                                // height: Dimensions.height1 * 200,
                                                // width: Dimensions.width1 * 120,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions.dimen20),
                                                  color: Colors.white,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        cartController.addItem(
                                                            cartList[index]
                                                                .product!,
                                                            -1);
                                                      },
                                                      child: Icon(Icons.remove,
                                                          color: AppColors
                                                              .signColor),
                                                    ),
                                                    SizedBox(
                                                        width:
                                                            Dimensions.dimen10),
                                                    BigText(
                                                      text: cartList[index]
                                                          .quantity
                                                          .toString(),
                                                    ),
                                                    SizedBox(
                                                        width:
                                                            Dimensions.dimen10),
                                                    GestureDetector(
                                                      onTap: () {
                                                        cartController.addItem(
                                                            cartList[index]
                                                                .product!,
                                                            1);
                                                      },
                                                      child: Icon(Icons.add,
                                                          color: AppColors
                                                              .signColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ):Center(child: const NoDataPage(text: "购物车竟然是空的"));
            },
          )
        ],
      ),
      bottomNavigationBar:
          GetBuilder<CartController>(builder: (cartController) {
        return Container(
          height: Dimensions.dimen120 * 0.78,
          width: double.maxFinite,
          padding: EdgeInsets.only(
            top: Dimensions.dimen20,
            bottom: Dimensions.dimen20,
            left: Dimensions.dimen20,
            right: Dimensions.dimen20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.dimen20 * 2),
              topRight: Radius.circular(Dimensions.dimen20 * 2),
            ),
            color: AppColors.buttonBackgroundColor,
          ),
          child: cartController.getItems.isNotEmpty?Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Minus, Plus and Counting of Food
              Container(
                padding: EdgeInsets.only(
                  top: Dimensions.dimen15,
                  bottom: Dimensions.dimen15,
                  left: Dimensions.dimen20,
                  right: Dimensions.dimen20,
                ),
                // height: Dimensions.height1 * 200,
                // width: Dimensions.width1 * 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.dimen20),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: Dimensions.dimen10),
                    BigText(
                        text: "\$ " + cartController.totalAmount.toString()),
                    SizedBox(width: Dimensions.dimen10),
                  ],
                ),
              ),

              // Add Button
              GestureDetector(
                onTap: () {
                  cartController.addToHistory();
                },
                child: Container(
                  padding: EdgeInsets.only(
                    top: Dimensions.dimen15,
                    bottom: Dimensions.dimen15,
                    left: Dimensions.dimen20,
                    right: Dimensions.dimen20,
                  ),
                  // height: Dimensions.height1 * 200,
                  // width: Dimensions.width1 * 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.dimen20),
                    color: AppColors.mainColor,
                  ),

                  child: BigText(
                    text: " CHECK OUT",
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ):Container(),
        );
      }),
    );
  }
}

void _onSlideClicked(int action) {

  Get.snackbar(
    "Button Clicked ",
    "您点击了侧滑按钮",
    backgroundColor: AppColors.mainColor,
    colorText: Colors.white,
  );
  

}
