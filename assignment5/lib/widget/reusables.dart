import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class kTextFormField extends StatelessWidget {
  kTextFormField({
    required this.lable,

    Key? key,
    this.inputformaters,
    required this.kController,
    this.suffixIcon,
    required this.keybordtype,
    required this.obscure,
    required this.icon,
    required this.validator,
  }) : super(key: key);

  final TextEditingController kController;
  String lable;
  List <TextInputFormatter> ?inputformaters;
  Widget icon;
  TextInputType keybordtype;
  Widget? suffixIcon;
  bool obscure;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.red.withOpacity(.08),
          Colors.white.withOpacity(0.4),
          Colors.white.withOpacity(0.6),
          Colors.white.withOpacity(0.4),
          Colors.red.withOpacity(.08),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        // keyboardAppearance: TextInputType.text,
        textInputAction: TextInputAction.next,
        keyboardType: keybordtype,
        textAlign: TextAlign.start,
        controller: kController,
        cursorHeight: 25,
        cursorRadius: const Radius.circular(9),
        scrollPadding: const EdgeInsets.symmetric(horizontal: 5),
        // style: ,
        inputFormatters: inputformaters,
        validator: validator,
        obscureText: obscure,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: icon,
          labelText: lable,
          labelStyle:
              const TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide:  const BorderSide(
                color: Colors.redAccent,
                style: BorderStyle.solid,
              strokeAlign: 20,
               ),
          ),
        ),
      ),
    );
  }
}
class MyButton extends StatelessWidget {
  const MyButton({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: 144 / 3,
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(24 ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 55 / 3,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}