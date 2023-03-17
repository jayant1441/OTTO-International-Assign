import 'package:flutter/material.dart';


class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final  IconData myIcon;
  final String myLabelText;
  final bool toHide;
  TextInputField({Key? key ,
  required this.controller,
    required this.myIcon,
    required this.myLabelText,
    this.toHide = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: toHide,
      controller: controller,

      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        icon: Icon(myIcon,),

        labelText: myLabelText,
        labelStyle: TextStyle(
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              // color: Colors.white,
            )),
        focusedBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          // color: Colors.white,
        ), ),

      ),


    );
  }
}
