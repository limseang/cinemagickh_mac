import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miss_planet/util/dimensions.dart';
import 'package:miss_planet/util/style.dart';

class CustomTextfield extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final Widget? surfix;
  final bool isReadOnly;
  final void Function(String)? onChange;
  final void Function()? onTap;
  final Color? colors;
  final int? maxLines;
  final TextStyle ?hintTextStyle;
  final TextStyle ?textStyle;
  final TextInputType? textInputType;
  final TextAlign? textAlign;
  final TextInputAction? textInputAction;
  final bool isFormat;
  final autofillHints;
  final bool isValidate;
  final List<TextInputFormatter>? inputFormatters;

  // final 
  const CustomTextfield({super.key, this.controller, this.hintText, this.labelText, this.surfix, this.isReadOnly = false, this.onTap, this.colors, this.onChange, this.maxLines, this.hintTextStyle, this.textStyle, this.textInputType, this.textAlign, this.textInputAction,  this.isFormat = false, this.inputFormatters, this.autofillHints, this.isValidate = false});

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.labelText == null ? const SizedBox(): Align(alignment: Alignment.centerLeft, child: Text(widget.labelText!, style: textStyleRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
        widget.labelText == null ? const SizedBox(): const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        SizedBox(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: TextFormField(
              autofillHints: widget.autofillHints,
              textInputAction: widget.textInputAction ?? TextInputAction.next,
              textAlign: widget.textAlign ?? TextAlign.start,
              keyboardType: widget.textInputType,
              onChanged: (value) {
                if(widget.onChange != null){
                widget.onChange!(value);
                }
                setState(() {  
                });
              },
              validator: widget.isValidate ?  (value) {
                if (value!.isEmpty) {
                  return '${widget.labelText} is required';
                }
                return null;
              }: null,
              inputFormatters: widget.inputFormatters,
              onTap: widget.onTap,
              style: textStyleRegular,
              readOnly: widget.isReadOnly,
              controller: widget.controller,
              maxLines: widget.maxLines,
              decoration: InputDecoration(
                suffixIcon: widget.surfix,
                fillColor: widget.colors ??  Colors.white.withOpacity(0.2),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                border: InputBorder.none,
                hintText: widget.hintText,
                helperStyle: widget.hintTextStyle,
                
              ),
            ),
          ),
        ),
      ],
    );
  }
}