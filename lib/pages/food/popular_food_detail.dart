import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../routes/route_helper.dart';
import '../../widgets/expandable_text.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String prevPage;
  const PopularFoodDetail(
      {Key? key, required this.pageId, required this.prevPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductModel product =
        Get.find<PopularProductController>().popularProductList[pageId];

    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.dimen350,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "${AppConstants.IMAGE_UPLOADS_URL}${product.img}"),
                ),
              ),
            )),
        Positioned(
          top: Dimensions.dimen45,
          left: Dimensions.dimen20,
          right: Dimensions.dimen20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    if (prevPage == "initial") {
                      Get.toNamed(RouteHelper.getInitial());
                    } else if (prevPage == "cartpage") {
                      Get.toNamed(RouteHelper.getCartPage());
                    }
                  },
                  child: AppIcon(icon: Icons.arrow_back_ios)),
              GetBuilder<PopularProductController>(builder: (controller) {

                print("=========> ${controller.totalItems}");
                return GestureDetector(
                  onTap: () {
                    controller.totalItems >= 1
                        ? Get.toNamed(RouteHelper.getCartPage())
                        : controller.EmptyCart();
                  },
                  child: Stack(
                    children: [
                      AppIcon(
                        icon: Icons.shopping_cart_outlined,
                      ),
                      controller.totalItems >= 1
                          ? Positioned(
                              right: 0,
                              top: 0,
                              child: AppIcon(
                                icon: Icons.circle,
                                size: Dimensions.dimen20,
                                iconColor: Colors.transparent,
                                backgroundColor: AppColors.mainColor,
                              ),
                            )
                          : Container(),
                      Get.find<PopularProductController>().totalItems >= 1
                          ? Positioned(
                              right: Dimensions.dimen1 * 7,
                              top: Dimensions.dimen1 * 3,
                              child: BigText(
                                text: Get.find<PopularProductController>()
                                    .totalItems
                                    .toString(),
                                size: Dimensions.dimen1 * 12,
                                color: Colors.white,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.dimen350 - 20,
            child: Container(
                padding: EdgeInsets.only(
                    left: Dimensions.dimen20,
                    right: Dimensions.dimen20,
                    top: Dimensions.dimen20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.dimen20),
                      topRight: Radius.circular(Dimensions.dimen20)),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name!),
                    SizedBox(
                      height: Dimensions.dimen20,
                    ),
                    BigText(text: "Introduce"),
                    SizedBox(height: Dimensions.dimen20),
                    Expanded(
                      child: SingleChildScrollView(
                          child: ExpandableText(text: product.description!)),
                    ),
                  ],
                ))),
      ]),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProduct) {
          return Container(
            height: Dimensions.dimen120,
            padding: EdgeInsets.only(
              top: Dimensions.dimen30,
              bottom: Dimensions.dimen30,
              left: Dimensions.dimen20,
              right: Dimensions.dimen20,
            ),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.dimen20 * 2),
                  topRight: Radius.circular(Dimensions.dimen20 * 2),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: Dimensions.dimen15,
                    bottom: Dimensions.dimen15,
                    left: Dimensions.dimen20,
                    right: Dimensions.dimen20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.dimen20),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(false);
                        },
                        child: Icon(Icons.remove, color: AppColors.signColor),
                      ),
                      SizedBox(
                        width: Dimensions.dimen10 / 2,
                      ),
                      BigText(text: popularProduct.inCartItems.toString()),
                      SizedBox(
                        width: Dimensions.dimen10 / 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(true);
                        },
                        child: Icon(Icons.add, color: AppColors.signColor),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    popularProduct.addItem(product);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                      top: Dimensions.dimen15,
                      bottom: Dimensions.dimen15,
                      left: Dimensions.dimen20,
                      right: Dimensions.dimen20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.dimen20),
                      color: AppColors.mainColor,
                    ),
                    child: BigText(
                      text: "\$ ${product.price} | Add to cart",
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
