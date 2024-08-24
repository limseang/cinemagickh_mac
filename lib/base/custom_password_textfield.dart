import 'package:flutter/material.dart';
import 'package:miss_planet/util/dimensions.dart';
import 'package:miss_planet/util/style.dart';


class CustomPasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintTxt;
  final String? onchange;
  final bool? ischangepwd;
  final Color? color;
  final  autofillHints;

  final TextInputType? textInputAction;

  const CustomPasswordTextField(
      {super.key, required this.controller,
      this.hintTxt,
      this.onchange,
      this.ischangepwd,
      this.textInputAction,
      this.color,
     this.autofillHints});

  @override
  _CustomPasswordTextFieldState createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: TextFormField(
        autofillHints: widget.autofillHints,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: widget.textInputAction,
       style: textStyleRegular,
        onChanged: (value) {
          setState(() {
            
          });
          // widget.authController?.settetx(value);
          if (value.isNotEmpty) {
            // widget.authController?.setispwInput(true);
          } else {
            // widget.authController?.setispwInput(false);
          }
        },
        controller: widget.controller,
        obscureText: _obscureText,
        obscuringCharacter: "*",
        // style: textStyleRegular.copyWith(color: Colors.black,fontSize: 16,letterSpacing: !_obscureText ? 0 : 2),
        decoration: InputDecoration(
          hintText: widget.hintTxt,
          contentPadding: EdgeInsets.only(left: 14,top: !_obscureText? 0: widget.controller.text.isEmpty? 0: 5),
          isDense: true,
          fillColor: widget.color ??  Colors.white.withOpacity(0.2),
          filled: true,
          border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelStyle: TextStyle(fontSize: Dimensions.fontSizeDefault),
          suffixIcon: Padding(padding: const EdgeInsets.only(right: 4.0),child: 
          IconButton(icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility,size: 22),color: const Color(0xff8B8B8B),onPressed: _toggle)
          ),
        ),
      ),
    );
  }
}
