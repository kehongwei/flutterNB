import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:get/get.dart';

import '../../base/custom_loader.dart';
import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';
import '../../models/signup_body_model.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class SignUpPage extends StatelessWidget {
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final rePasswordController = TextEditingController();

  final signUpImages = ["g.png","w.png"];

  SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController) {
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
              // email
              SizedBox(
                height: Dimensions.dimen20,
              ),
              // password
              AppTextField(
                  hintText: "name",
                  iconData: Icons.person,
                  textEditingController: nameController),
              SizedBox(
                height: Dimensions.dimen20,
              ),
              // name
              AppTextField(
                  hintText: "password",
                  iconData: Icons.password,
                  textEditingController: passwordController),
              SizedBox(
                height: Dimensions.dimen20,
              ),
              AppTextField(
                  hintText: "rePassword",
                  iconData: Icons.password,
                  textEditingController: rePasswordController),
              SizedBox(
                height: Dimensions.dimen20,
              ),
              GestureDetector(
                onTap: () {
                  _registration(authController);
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
                    text: "Sign Up",
                    size: Dimensions.dimen20 + Dimensions.dimen20 / 2,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: Dimensions.dimen10,
              ),
              // <a href=""></a>
              // TapGestureRecognizer()..onTap = ()=>
              // Tag Line
              RichText(
                text: TextSpan(
                    recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
                    text: "Have an account already?",
                    style: TextStyle(
                        color: Colors.grey[500], fontSize: Dimensions.dimen20)),
              ),
              SizedBox(
                height: Dimensions.screenHeight * 0.05,
              ),
              // Signup options
              RichText(
                text: TextSpan(
                    text: "sign Up using one of the following methods",
                    style: TextStyle(
                        color: Colors.grey[500], fontSize: Dimensions.dimen16)),
              ),
              Wrap(
                children: List.generate(
                    2,
                        (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: Dimensions.dimen30,
                        backgroundImage: AssetImage(
                          "assets/image/${signUpImages[index]}",
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ) : const CustomLoader();
      },),
    );
  }

  Future<void> _registration(AuthController authController) async {
    String name = nameController.text.trim();
    String password = passwordController.text.trim();
    String rePassword = rePasswordController.text.trim();

    if (name.isEmpty) {
      showCustomSnackBar("请输入名称", title: "Name");
      return;
    }

    if (password.isEmpty) {
      showCustomSnackBar("请输入密码", title: "Password");
      return;
    }
    if (password.length < 6) {
      showCustomSnackBar("密码至少六位数长度", title: "Password");
      return;
    }

    if (password != rePassword) {
      showCustomSnackBar("两次密码不相等", title: "Password");
      return;
    }


    {
      showCustomSnackBar("All looks good", title: "Perfect");
      SignUpBody signUpBody = SignUpBody(name: name,  password: password,repassword: rePassword);
      //print(signUpBody.toString());

      authController.registration(signUpBody).then((responseModel) {
        if (responseModel.isSuccess) {
          print("Success registration");
          Get.offNamed(RouteHelper.getInitial());
        } else {
          showCustomSnackBar(responseModel.message.toString());
        }
      });
    }
  }

  void reg() async {
    Map<String, String>_mainHeaders = {
      // 'Content-type':"application/json; charset=UTF-8"
      'Content-type':"application/x-www-form-urlencoded"
    };
    var url = Uri.https('www.wanandroid.com', '/user/register');
    var map = {'username':'kksd','password':'123456','repassword':'123456'};
    
    var response = await http.post(url, body: map,headers: _mainHeaders);
    print(response.statusCode);
  }



}
