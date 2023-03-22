import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/pages/home/food_page_body.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../utils/colors.dart';
import '../../utils/rive_utils.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {

  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        color: Colors.blue,
        backgroundColor: Colors.white,
        displacement: 50, onRefresh: _loadResource,
        child:  Column(
      children: [
        Container(
          child: Container(
            margin: EdgeInsets.only(top: Dimensions.dimen45,bottom: Dimensions.dimen15),
            padding: EdgeInsets.only(left: Dimensions.dimen20,right: Dimensions.dimen20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(text: "America",color: AppColors.mainColor,),
                    Row(
                      children: [
                        SmallText(text: "California",color: Colors.black54,),
                        Icon(Icons.arrow_drop_down_rounded)
                      ],
                    )
                  ],
                ),
                 Container(
                  color: Color(0x3D63AFFF),
                  width: 120,
                  height: 40,
                  child: RiveAnimation.asset(
                        "assets/rive/smile.riv",
                         fit: BoxFit.cover,
                )),
              ],
            ),
          ),
        ),
        Expanded(child: SingleChildScrollView(
          child: FoodPageBody(),
        )),
      ],
    ));
  }
}
