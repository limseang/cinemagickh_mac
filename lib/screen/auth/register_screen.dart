import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:miss_planet/base/snackbar.dart';
import 'package:miss_planet/controller/auth_controller.dart';
import 'package:miss_planet/helper/custo_scaffold.dart';
import 'package:miss_planet/screen/auth/helper/auth_helper.dart';
import 'package:miss_planet/screen/auth/login_screen.dart';
import 'package:miss_planet/util/app_constants.dart';
import 'package:miss_planet/util/color_resources.dart';
import 'package:miss_planet/util/dimensions.dart';
import 'package:miss_planet/util/next_screen.dart';
import 'package:miss_planet/util/style.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isshow = true;
  bool _phoneLogin = false;
  bool _isloding = false;
  bool _otp = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();


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
                      nextScreen(context, LoginScreen());
                    },
                    child: Container(
                      width: Get.width * 0.2,
                      height: 50,
                      decoration: BoxDecoration(
                        color: ColorResources.defaultBackgroundGrey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text('login'.tr, style: textStyleRegular,),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: Get.height * 0.08),
              Container(
                width: 300,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage("assets/images/img.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              _isloding == true ?
              Container(
                width: 100,
                height: 100,
                child: LottieBuilder.asset(AppConstants.customLoading),
              )
                  :Column(children: [
                SizedBox(height: 20,),
                Column(
                  children: [
                    CustomAuthTextField(
                      hintText: 'input_your_name'.tr,
                      icon: Icons.person,
                      controller: nameController,
                      fieldType: AuthFieldType.name,
                    ),
                    SizedBox(height: 20,),
                    CustomAuthTextField(
                      hintText: 'input_your_email'.tr,
                      icon: Icons.email,
                      controller: emailController,
                      fieldType: AuthFieldType.email,
                    ),
                    SizedBox(height: 20,),
                    CustomAuthTextField(
                      hintText: 'input_your_phone'.tr,
                      icon: Icons.phone,
                      controller: phoneController,
                      fieldType: AuthFieldType.phone,
                    ),
                    SizedBox(height: 20,),
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
              SizedBox(height: Dimensions.MARGIN_SIZE_LARGE),
              _isloding == true ? SizedBox():  Container(
                alignment: Alignment.center,
                width: Get.width * 0.90,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: auth.hasEmail == true &&  auth.hasPassword == true &&  auth.hasPhone == true &&  auth.hasName == true ? ColorResources.defaultBlue : Colors.grey[200],
                ),
                child: TextButton(
                  onPressed: () {
                    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty && phoneController.text.isNotEmpty && nameController.text.isNotEmpty) {
                      setState(() {
                        _isloding = true;
                      });

                      authController.signUp(email: emailController.text, password: passwordController.text, phone: phoneController.text, name: nameController.text).then((_) {
                        setState(() {
                          _isloding = false;
                        });
                      });
                    }
                    else {
                      showCustomSnackBar('fill_all_fields'.tr);
                    }
                  },
                  child: Text('Register'.tr, style: TextStyle(color: auth.hasEmail == true &&  auth.hasPassword == true &&  auth.hasPhone == true &&  auth.hasName == true ?Colors.white : Colors.black, fontSize: 20)),
                ),
              ),



            ],
          );
        }
      ),
    ));
  }
}
