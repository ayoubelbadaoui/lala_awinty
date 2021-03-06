import 'package:flutter/material.dart';

class AppInput extends StatelessWidget {
  String? hint;
  Widget? prefixIcon;
  TextEditingController? controller;
  double? widthFactor;
  final validator;
  String? initialValue;
  bool? obscureText;
  TextInputType? textInputType;
  Widget? suffix;
  int? height;
  AppInput(
      {required this.hint,
      this.prefixIcon,
      this.controller,
      this.widthFactor,
      required this.validator,
      this.initialValue,this.obscureText,
        this.textInputType,
        this.suffix,
        this.height
      });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor ?? 1,
      child: TextFormField(
        minLines: height ?? 1,
        maxLines: height == null ? 1 : null,
        controller: controller,
        validator: validator,
        keyboardType: height != null ? (TextInputType.multiline) : textInputType??TextInputType.text,
        initialValue: initialValue,
        obscureText: obscureText??false,
        style: const TextStyle(
            //fontSize: 15, fontWeight: FontWeight.w400, color: Color(0XFF607D8B)
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Color(0XFF263238)),
             decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(40.0),
            ),
            //enabledBorder: InputBorder.none,
            hintText: hint ?? '',
            prefixIcon: prefixIcon,
            //suffix: obscureText! ?? IconButton(onPressed: null, icon: Icon(Icons.ten_k)),
            suffix: suffix,
            fillColor: const Color(0XFFDFDFDF),
            filled: true,
            contentPadding: const EdgeInsets.all(16),
            labelStyle: const TextStyle(color: Colors.red)),
      ),
    );
  }
}
