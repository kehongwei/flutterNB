import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/widgets/Icon_and_text.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_column.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  var _scaleFactor = 0.8;
  var height = Dimensions.pageViewContainer;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              ? Container(
                  height: Dimensions.pageView,
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: popularProducts.popularProductList.length,
                      itemBuilder: (context, position) {
                        return _buildPageItem(position,
                            popularProducts.popularProductList[position]);
                      }),
                )
              : CircularProgressIndicator(color: AppColors.mainColor);
        }),
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        SizedBox(
          height: Dimensions.dimen30,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.dimen30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(
                width: Dimensions.dimen10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(text: ".", color: Colors.black26),
              ),
              SizedBox(
                width: Dimensions.dimen10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: "food pairing"),
              ),
            ],
          ),
        ),
        GetBuilder<RecommendedProductController>(
            builder: (recommendedProducts) {
          return ListView.builder(
              itemCount: recommendedProducts.recommendedProductList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getRecommendedFoodDetail(
                        index, "initial"));
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.dimen20,
                        right: Dimensions.dimen20,
                        bottom: Dimensions.dimen10),
                    child: Row(
                      children: [
                        Container(
                            width: Dimensions.dimen120,
                            height: Dimensions.dimen120,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.dimen20),
                                color: Colors.white38,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        "${AppConstants.IMAGE_UPLOADS_URL}/${recommendedProducts.recommendedProductList[index].img!}")))),
                        Expanded(
                          child: Container(
                            height: Dimensions.dimen100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(Dimensions.dimen20),
                                    bottomRight:
                                        Radius.circular(Dimensions.dimen20)),
                                color: Colors.white),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: Dimensions.dimen10,
                                  right: Dimensions.dimen10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigText(
                                      text: recommendedProducts
                                          .recommendedProductList[index].name),
                                  SizedBox(
                                    height: Dimensions.dimen10,
                                  ),
                                  SmallText(text: "With Chinese characteristics"),
                                  SizedBox(
                                    height: Dimensions.dimen10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      IconAndText(
                                          icon: Icons.circle_sharp,
                                          text: "Normal",
                                          iconColor: AppColors.iconColor1),
                                      IconAndText(
                                          icon: Icons.location_on,
                                          text: "1.7km",
                                          iconColor: AppColors.mainColor),
                                      IconAndText(
                                          icon: Icons.access_time_rounded,
                                          text: "Normal",
                                          iconColor: AppColors.iconColor2),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
        }),
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix = new Matrix4.identity();
    var currScale = 0.0;
    if (index == _currPageValue.floor()) {
      currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
    } else if (index == _currPageValue.floor() + 1) {
      currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
    } else if (index == _currPageValue.floor() - 1) {
      currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
    } else {
      currScale = 0.8;
    }
    var currTrans = height * (1 - currScale) / 2;
    matrix = Matrix4.diagonal3Values(1, currScale, 1)
      ..setTranslationRaw(0, currTrans, 0);
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFoodDetail(index, "initial"));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.dimen30),
                  color: Color(0xFF69c5df),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "${AppConstants.IMAGE_UPLOADS_URL}${popularProduct.img!}"))),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.dimen30,
                  right: Dimensions.dimen30,
                  bottom: Dimensions.dimen20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.dimen20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 0),
                    ),
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.dimen15,
                    left: Dimensions.dimen15,
                    right: Dimensions.dimen15),
                child: AppColumn(text: popularProduct.name!),
              ),
            ),
          )
        ],
      ),
    );
  }
}
