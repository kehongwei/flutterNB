import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/models/user_bean.dart';

import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:get/get.dart';
import '../../base/custom_loader.dart';
import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/home_controller.dart';
import '../../data/repository/auth_repo.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
        return !authController.isLoading ? SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // App Logo
              Container(
                margin: EdgeInsets.only(
                    top: Dimensions.screenHeight * 0.05,
                    bottom: Dimensions.screenHeight * 0.05),
                height: Dimensions.screenHeight * 0.25,
                //width: double.infinity,
                alignment: Alignment.center,
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 80,
                  backgroundImage: AssetImage(
                    "assets/image/logo part 1.png",
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: Dimensions.dimen20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello", style: TextStyle(fontSize: Dimensions.dimen20*3+Dimensions.dimen20/2, fontWeight: FontWeight.bold),),
                    Text("Sign into your account", style: TextStyle(fontSize: Dimensions.dimen20, fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              SizedBox(
                height: Dimensions.dimen20,
              ),
              // phone
              AppTextField(
                  hintText: "username",
                  iconData: Icons.person,
                  textEditingController: usernameController),
              SizedBox(
                height: Dimensions.dimen20,
              ),
              // password
              AppTextField(
                  hintText: "Password",
                  iconData: Icons.password_sharp,
                  textEditingController: passwordController),
              SizedBox(
                height: Dimensions.dimen20,
              ),
              // Sign into your account Text 부분
              Padding(
                padding: EdgeInsets.only(right: Dimensions.dimen20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: "Sign into your account",
                          style: TextStyle(
                              color: Colors.grey[500], fontSize: Dimensions.dimen20)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Dimensions.dimen20,
              ),

              // SignIn Button, message, other method's message & buttons
              GestureDetector(
                onTap: () {
                  _login(authController);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: Dimensions.screenWidth / 2,
                  height: Dimensions.screenHeight / 13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.dimen30),
                    color: AppColors.mainColor,
                  ),
                  child: BigText(
                    text: "Sign In",
                    size: Dimensions.dimen20 + Dimensions.dimen20 / 2,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: Dimensions.dimen20*2,
              ),

              RichText(
                text: TextSpan(
                    text: "Don\'t have an account? ",
                    style: TextStyle(
                        color: Colors.grey[500], fontSize: Dimensions.dimen20),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()..onTap = ()=> Get.to(()=> SignUpPage(), transition: Transition.fade),
                        text: "Create ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[500], fontSize: Dimensions.dimen20),)
                    ]),
              ),
              SizedBox(height: Dimensions.screenHeight*0.05,),
            ],
          ),
        ):const CustomLoader();
       },),
    );
  }
  Future<void> _login(AuthController authController) async {
    String phone = usernameController.text.trim();
    String password = passwordController.text.trim();
    if (phone.isEmpty) {
      showCustomSnackBar("Type in your username", title: "Username");
      return;
    }
    if (password.isEmpty) {
      showCustomSnackBar("Type in your password", title: "Password");
      return;
    }
    if (password.length < 6) {
      showCustomSnackBar("Password must be more than 6 characters", title: "Password length");
      return;
    }
        {
      showCustomSnackBar("All looks good", title: "Perfect");
      //print(signUpBody.toString());
      authController.login(phone, password).then((wanResponse) {
        print("------${wanResponse.errorCode}-----");

        // var bean = UserBean.fromJson();
        if (wanResponse.errorCode == 0) {
           Get.find<HomeController>().refreshPage();
        } else {
          showCustomSnackBar(wanResponse.errorMsg);
        }
      });


    }
  }
}
