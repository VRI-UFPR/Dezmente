import 'dart:ffi';

import 'package:flutter/material.dart';

class CustomTextButtom extends StatefulWidget {
  final String text;
  final Color bgColor;
  final VoidCallback callback;
  final EdgeInsets sizes;

  const CustomTextButtom({
    Key? key,
    required this.callback,
    this.text = "",
    required this.bgColor,
    required this.sizes,
  }) : super(key: key);

  @override
  State<CustomTextButtom> createState() => _CustomTextButtomState();
}

class _CustomTextButtomState extends State<CustomTextButtom> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Container(
        margin: widget.sizes,
        child: Text(
          widget.text,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: "montserrat",
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      style: ButtonStyle(
        shadowColor: MaterialStateProperty.all<Color>(Colors.black),
        elevation: MaterialStateProperty.all(20),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(7))),
        ),
        alignment: Alignment.center,
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.all(13),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(widget.bgColor),
      ),
      onPressed: widget.callback,
    );
  }
}
