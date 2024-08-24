import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miss_planet/controller/auth_controller.dart';
import 'package:miss_planet/util/color_resources.dart';

enum AuthFieldType {
  phone,
  email,
  password,
  name,
}

class CustomAuthTextField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType inputType;
  final AuthFieldType fieldType;

  CustomAuthTextField({
    required this.hintText,
    required this.icon,
    required this.controller,
    this.isPassword = false,
    this.inputType = TextInputType.text,
    this.fieldType = AuthFieldType.phone,
  });

  @override
  _CustomAuthTextFieldState createState() => _CustomAuthTextFieldState();
}

class _CustomAuthTextFieldState extends State<CustomAuthTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    if (widget.fieldType != AuthFieldType.password) {
      _obscureText = false;
    }
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: Get.width * 0.90,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword || widget.fieldType == AuthFieldType.password ? _obscureText : false,
        keyboardType: widget.inputType,
        onChanged: (String value) {

          if(widget.fieldType == AuthFieldType.phone){
            if(value.length > 10){
              Get.find<AuthController>().setHasPhone(true);
              return;
            }
            else if(value.isNotEmpty){
              Get.find<AuthController>().setHasPhone(true);
            }
          }
          else if(widget.fieldType == AuthFieldType.email){
            if(value.isNotEmpty){
              Get.find<AuthController>().setHasEmail(true);
            }
            else {
              Get.find<AuthController>().setHasEmail(false);
            }
          }
          else if(widget.fieldType == AuthFieldType.password){
            if(value.isNotEmpty){
              Get.find<AuthController>().setHasPassword(true);
            }
            else {
              Get.find<AuthController>().setHasPassword(false);
            }
          }
          else if(widget.fieldType == AuthFieldType.name){
            if(value.isNotEmpty){
              Get.find<AuthController>().setHasName(true);
            }
            else {
              Get.find<AuthController>().setHasName(false);
            }
          }

          setState(() {
            widget.controller.text = value;
          });
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 20),
          hintText: widget.controller.text.isEmpty ? widget.hintText.tr : '',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(widget.icon),

          suffixIcon: (widget.isPassword || widget.fieldType == AuthFieldType.password)
              ? IconButton(
            icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
            onPressed: _toggleVisibility,
          )
              : null,
          border: InputBorder.none,
        ),
        textAlignVertical: TextAlignVertical.center,
      ),
    );
  }
}