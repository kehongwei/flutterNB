import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../base/custom_app_bar.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/app_constants.dart';
import '../../widgets/account_widget.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  var authController = Get.find<AuthController>();
  // bool userLoggedIn = authController.userLoggedIn();
  var sp = Get.find<SharedPreferences>();
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {

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
              GestureDetector(
                onTap: () {
                  _onImageButtonPressed(ImageSource.gallery, context: context);
                },
                child:  CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 80,
                  backgroundImage:getHead().isNotEmpty  ? FileImage(File(getHead())) : const AssetImage("assets/image/boys.png") as ImageProvider<Object>,
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

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {

    {
      try {
        final XFile? pickedFile = await _picker.pickImage(
          source: source,
          maxWidth: null,
          maxHeight: null,
          imageQuality: null,
        );
        setState(() {
          if(pickedFile != null ) {
            saveHead(pickedFile.path);
          }
        });
      } catch (e) {
        // setState(() {
        //   _pickImageError = e;
        // });
      }

    }
  }

  Future<void> saveHead(String path) async {
    try {
      await sp.setString(AppConstants.HEAD, path);
    } catch (e) {
      throw e;
    }
  }

  String getHead() {
    return sp.getString(AppConstants.HEAD) ?? "";
  }
}




typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);


