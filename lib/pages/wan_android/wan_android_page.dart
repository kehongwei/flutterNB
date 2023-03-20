import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:food_delivery/controllers/wan_controller.dart';
import 'package:get/get.dart';
import '../../base/custom_app_bar.dart';
import '../../widgets/big_text.dart';

class WanAndroidPage extends StatelessWidget {

  const WanAndroidPage({Key? key}) : super(key: key);

  static const List<String> imgs =
  [
    "assets/image/IMG_02.JPG",
    "assets/image/IMG_03.JPG",
    "assets/image/IMG_04.JPG",
    "assets/image/IMG_05.JPG",];



  Future<void> _getArticle() async {
    await Get.find<WanController>().getArticle();
  }

  @override
  Widget build(BuildContext context) {
    _getArticle();
    return Scaffold(
      appBar: CustomAppBar(title: "玩安卓",),
      body: GetBuilder<WanController>(builder: (wanController){
        return MasonryGridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          itemCount: wanController.articleList.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Container(
                  height: (index == 0) ? 250 :300,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(imgs[index%4]),
                        fit: BoxFit.cover,
                      )
                  ),
                ),
                const Positioned.fill(child: DecoratedBox(decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent,Colors.black],
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    stops: [0.4,1.0],
                  ),
                ),
                ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8,right: 8),
                    child: Center(
                      child: BigText(
                      size: 14,
                      color: Colors.white,
                      text: wanController.articleList[index].title!,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },)
    );
  }
}
