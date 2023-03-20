import 'package:flutter/material.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../base/custom_app_bar.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/app_constants.dart';
import '../../widgets/account_widget.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authController = Get.find<AuthController>();
    bool userLoggedIn = authController.userLoggedIn();
    var sp = Get.find<SharedPreferences>();

    return Scaffold(
      appBar: CustomAppBar(title: "Profile",),
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(
            top: Dimensions.dimen20,
          ),
          child: Column(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 80,
                backgroundImage: AssetImage(
                  "assets/image/boys.png",
                ),
              ),
              SizedBox(
                height: Dimensions.dimen30,
              ),
              AccountWidget(
                  appIcon: AppIcon(
                    icon: Icons.person,
                    backgroundColor: AppColors.mainColor,
                    iconColor: Colors.white,
                    iconSize: Dimensions.dimen10 * 5 / 2,
                    size: Dimensions.dimen10 * 5,
                  ),
                  bigText: BigText(
                    text: sp.getString(AppConstants.PHONE) ?? "NONE",
                  )),
              SizedBox(
                height: Dimensions.dimen30,
              ),
              AccountWidget(
                  appIcon: AppIcon(
                    icon: Icons.phone,
                    backgroundColor: AppColors.yellowColor,
                    iconColor: Colors.white,
                    iconSize: Dimensions.dimen10 * 5 / 2,
                    size: Dimensions.dimen10 * 5,
                  ),
                  bigText: BigText(
                    text: "18310006079",
                  )),
              SizedBox(
                height: Dimensions.dimen30,
              ),
              AccountWidget(
                  appIcon: AppIcon(
                    icon: Icons.location_on,
                    backgroundColor: AppColors.mainColor,
                    iconColor: Colors.white,
                    iconSize: Dimensions.dimen10 * 5 / 2,
                    size: Dimensions.dimen10 * 5,
                  ),
                  bigText: BigText(
                    text: "36 Mayland Trail, Stoney Creek, L8J0G4",
                  )),
              SizedBox(
                height: Dimensions.dimen30,
              ),
              AccountWidget(
                  appIcon: AppIcon(
                    icon: Icons.message_outlined,
                    backgroundColor: Colors.redAccent,
                    iconColor: Colors.white,
                    iconSize: Dimensions.dimen10 * 5 / 2,
                    size: Dimensions.dimen10 * 5,
                  ),
                  bigText: BigText(
                    text: "Message",
                  )),
              SizedBox(
                height: Dimensions.dimen30,
              ),
              GestureDetector(
                onTap: () {
                  authController.clearSharedData();

                },
                child: AccountWidget(
                    appIcon: AppIcon(
                      icon: Icons.logout,
                      backgroundColor: Colors.redAccent,
                      iconColor: Colors.white,
                      iconSize: Dimensions.dimen10 * 5 / 2,
                      size: Dimensions.dimen10 * 5,
                    ),
                    bigText: BigText(
                      text: "Logout",
                    )),
              ),
              SizedBox(
                height: Dimensions.dimen30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
