import 'package:flutter/material.dart';
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
import '../../widgets/expandable_text.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String prevPage;
  const RecommendedFoodDetail(
      {Key? key, required this.pageId, required this.prevPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
    Get.find<RecommendedProductController>().recommendedProductList[pageId];
    var cartController = Get.find<CartController>();
    Get.find<PopularProductController>().initProduct(product, cartController);
    bool _pinned = true;
    bool _snap = false;
    bool _floating = false;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: _pinned,
            backgroundColor: AppColors.yellowColor,
            automaticallyImplyLeading:
            false, // property to deactive Back Button
            toolbarHeight: Dimensions.dimen1*80,
            title: Row(
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
                  child: AppIcon(icon: Icons.clear),
                ),
                GetBuilder<PopularProductController>(
                  builder: (controller) {
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
                            right: Dimensions.dimen1 * 0,
                            top: Dimensions.dimen1 * 0,
                            child: AppIcon(
                              icon: Icons.circle,
                              size: Dimensions.dimen1 * 20,
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
                  },
                ),

                //AppIcon(icon: Icons.shopping_cart_outlined),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(Dimensions.dimen20),
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(
                  top: Dimensions.dimen1*5,
                  bottom: Dimensions.dimen10,
                ),
                child: Center(
                  child: BigText(
                    text: "${product.name!}",
                    size: Dimensions.dimen26,
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.dimen20),
                    topRight: Radius.circular(Dimensions.dimen20),
                  ),
                  color: Colors.white,
                ),
              ),
            ),
            snap: _snap,
            floating: _floating,
            expandedHeight: Dimensions.dimen1*265,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.IMAGE_UPLOADS_URL + product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.dimen20, right: Dimensions.dimen20),
                  child: ExpandableText(
                    text: "${product.description!}",
                  ),
                ),
                SizedBox(height: Dimensions.dimen1*50),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: Dimensions.dimen20 * 2.5,
                  right: Dimensions.dimen20 * 2.5,
                  top: Dimensions.dimen10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(false);
                      },
                      child: AppIcon(
                        iconSize: Dimensions.dimen24,
                        icon: Icons.remove,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                      ),
                    ),
                    BigText(
                      text:
                      "\$ ${product.price!}  X  ${controller.inCartItems}",
                      color: AppColors.mainBlackColor,
                      size: Dimensions.dimen26,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(true);
                      },
                      child: AppIcon(
                        iconSize: Dimensions.dimen24,
                        icon: Icons.add,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.addItem(product);
                },
                child: Container(
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
                  child: Row(
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
                          borderRadius:
                          BorderRadius.circular(Dimensions.dimen20),
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.favorite,
                          color: AppColors.mainColor,
                        ),
                      ),

                      // Add Button
                      Container(
                        padding: EdgeInsets.only(
                          top: Dimensions.dimen15,
                          bottom: Dimensions.dimen15,
                          left: Dimensions.dimen20,
                          right: Dimensions.dimen20,
                        ),
                        // height: Dimensions.height1 * 200,
                        // width: Dimensions.width1 * 200,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(Dimensions.dimen20),
                          color: AppColors.mainColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BigText(
                                text: "\$${product.price!} | Add to cart",
                                color: Colors.white),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
