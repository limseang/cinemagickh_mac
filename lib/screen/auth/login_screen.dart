import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:miss_planet/base/snackbar.dart';
import 'package:miss_planet/controller/auth_controller.dart';
import 'package:miss_planet/helper/custo_scaffold.dart';
import 'package:miss_planet/screen/auth/helper/auth_helper.dart';
import 'package:miss_planet/screen/auth/register_screen.dart';
import 'package:miss_planet/util/app_constants.dart';
import 'package:miss_planet/util/color_resources.dart';
import 'package:miss_planet/util/dimensions.dart';
import 'package:miss_planet/util/material.dart';
import 'package:miss_planet/util/next_screen.dart';
import 'package:miss_planet/util/style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isshow = true;
  bool _phoneLogin = false;
  bool _isloding = false;
  bool _otp = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {

    return CustomScaffold(body: SingleChildScrollView(
      child: GetBuilder<AuthController>(
        builder: (auth) {
          return Column(
            children: [
              SizedBox(height: Dimensions.chooseReviewImageSize),
              Row(
                children: [
                 Container(
                   width: Get.width * 0.3,
                    height: 50,
                    decoration: BoxDecoration(
                      color: ColorResources.defaultBackgroundGrey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                   child: Center(
                     child: Text('language'.tr, style: textStyleRegular,),
                   ),
                 ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      nextScreen(context, RegisterScreen());
                    },
                    child: Container(
                      width: Get.width * 0.2,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: ColorResources.defaultBackgroundGrey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text('register'.tr, style: textStyleRegular,),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: Get.height * 0.08),
              Container(
                width: 100.w,
                height: 120.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage("assets/images/img.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              _isloding == true ?
              buildLoading()
                  :Column(children: [
                SizedBox(height: 40.h,),
                Column(
                  children: [
                    CustomAuthTextField(
                      hintText: 'input_your_email'.tr,
                      icon: Icons.email,
                      controller: emailController,
                      fieldType: AuthFieldType.email,
                    ),
                    SizedBox(height: 40.h,),
                    CustomAuthTextField(
                      hintText: 'input_your_password'.tr,
                      icon: Icons.lock,
                      controller: passwordController,
                      isPassword: _isshow,
                      fieldType: AuthFieldType.password,
                    ),
                  ],
                ),
              ],),
              SizedBox(height:40.h),
          _isloding == true ? SizedBox() :  Container(
                alignment: Alignment.center,
                width: Get.width * 0.90,
                height: 50.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: auth.hasEmail == true && auth.hasPassword == true  ? ColorResources.defaultBlue : Colors.grey[200],
                ),
                child: TextButton(
                  onPressed: () {
                    if(authController.hasEmail == true  && authController.hasPassword == true){
                      setState(() {
                        _isloding = true;
                      });

                      authController.login(email: emailController.text, password: passwordController.text).then((_) {
                        setState(() {
                          _isloding = false;
                        });
                      });
                    }
                    else {
                      showCustomSnackBar('fill_all_fields'.tr);
                    }
                  },
                  child: Text('login'.tr, style: TextStyle(color: auth.hasEmail == true && auth.hasPassword == true ?Colors.white : Colors.black, fontSize: 20)),
                ),
              ),



            ],
          );
        }
      ),
    ));
  }
}
