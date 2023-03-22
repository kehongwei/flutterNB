import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery/controllers/home_controller.dart';
import 'package:food_delivery/pages/account/account_page.dart';
import 'package:food_delivery/pages/auth/sign_in_page.dart';
import 'package:food_delivery/pages/cart/cart_history.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:rive/rive.dart';
import '../../controllers/auth_controller.dart';
import '../../models/rive_asset.dart';
import '../../utils/colors.dart';
import '../../utils/rive_utils.dart';
import '../../widgets/animated_bar.dart';
import '../wan_android/wan_android_page.dart';
import 'main_food_page.dart';
import '../../controllers/home_controller.dart';
//import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _seletectedIndex = 0;
  // late PersistentTabController _controller;
  RiveAsset selectedBottomNav = bottomNavs.first;

  static final List<Widget> pages = [
    MainFoodPage(),
    WanAndroidPage(),
    CartHistory(),
    SignInPage(),
  ];

  void onTapNav(int index) {
    setState(() {
      _seletectedIndex = index;
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = PersistentTabController(initialIndex: 0);
  // }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return GetBuilder<HomeController>(builder: (homeController){
      Get.find<AuthController>().userLoggedIn()?pages[3]=AccountPage():SignInPage();

      return Scaffold(
        body: IndexedStack(
          index: _seletectedIndex,
          children: pages,
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: backgroundColor2.withOpacity(0.8),
              borderRadius: const BorderRadius.all(Radius.circular(24)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...List.generate(
                  bottomNavs.length,
                      (index) => GestureDetector(
                    onTap: () {
                      bottomNavs[index].input!.change(true);
                      if (bottomNavs[index] != selectedBottomNav) {
                        setState(() {
                          selectedBottomNav = bottomNavs[index];
                        });
                      }
                      onTapNav(index);
                      Future.delayed(const Duration(seconds: 1), () {
                        bottomNavs[index].input!.change(false);
                      });

                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedBar(isActive: bottomNavs[index] == selectedBottomNav),
                        SizedBox(
                          height: 36,
                          width: 36,
                          child: Opacity(
                            opacity:
                            bottomNavs[index] == selectedBottomNav ? 1 : 0.5,
                            child: RiveAnimation.asset(
                              bottomNavs.first.src,
                              artboard: bottomNavs[index].artBoard,
                              onInit: (artboard) {
                                StateMachineController controller =
                                RiveUtils.getRiveController(artboard,
                                    stateMachineName: bottomNavs[index].stateMachineName);

                                bottomNavs[index].input =
                                controller.findSMI("active") as SMIBool;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
  // BottomNavigationBar(
  // selectedItemColor: AppColors.mainColor,
  // unselectedItemColor: Colors.amberAccent,
  // showSelectedLabels: false,
  // showUnselectedLabels: false,
  // currentIndex: _seletectedIndex,
  // selectedFontSize: 0.0,
  // unselectedFontSize: 0.1,
  // onTap: onTapNav,
  // items: [
  // BottomNavigationBarItem(
  // icon: Icon(
  // Icons.home_outlined,
  // ),
  // label: "Home",
  // ),
  // BottomNavigationBarItem(
  // icon: Icon(
  // Icons.archive,
  // ),
  // label: "History",
  // ),
  // BottomNavigationBarItem(
  // icon: Icon(
  // Icons.shopping_cart,
  // ),
  // label: "Cart",
  // ),
  // BottomNavigationBarItem(
  // icon: Icon(
  // Icons.person,
  // ),
  // label: "Account",
  // ),
  // ],
  // ),
}
