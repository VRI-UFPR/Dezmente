import 'package:flutter/material.dart';

class CustomTextInputField extends StatefulWidget {
  final String text;
  final TextInputType kbType;
  final int maxLength;
  final TextEditingController controller;

  const CustomTextInputField({
    Key? key,
    this.text = "",
    this.kbType = TextInputType.text,
    this.maxLength = 10,
    required this.controller,
  }) : super(key: key);

  @override
  State<CustomTextInputField> createState() => _CustomTextInputFieldState();
}

class _CustomTextInputFieldState extends State<CustomTextInputField> {
  @override
  Widget build(BuildContext context) {
    final double scrHfactor = MediaQuery.of(context).size.height / 640;
    final double scrWfactor = MediaQuery.of(context).size.width / 360;

    return SizedBox(
      width: 320 * scrWfactor,
      height: 50 * scrHfactor,
      child: TextField(
        controller: widget.controller,
        cursorColor: Colors.transparent,
        style: const TextStyle(
          fontFamily: "montserrat",
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(10, 2, 0, 0),
          border: const OutlineInputBorder(),
          counterStyle: const TextStyle(color: Colors.transparent),
          counter: const IgnorePointer(),
          fillColor: const Color(0xff4cc9f0),
          filled: true,
          hintText: widget.text,
          hintStyle: const TextStyle(
            fontFamily: "montserrat",
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        keyboardType: widget.kbType,
        autocorrect: false,
        maxLength: widget.maxLength,
        readOnly: false,
      ),
    );
  }
}

class CustomDropdownField extends StatefulWidget {
  final List<String> itemList;
  // String? value;
  final String text;

  const CustomDropdownField({
    Key? key,
    required this.itemList,
    //required this.value,
    this.text = "",
  }) : super(key: key);

  @override
  State<CustomDropdownField> createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  @override
  Widget build(BuildContext context) {
    final double scrHfactor = MediaQuery.of(context).size.height / 640;
    final double scrWfactor = MediaQuery.of(context).size.width / 360;
    String? value;

    return SizedBox(
      width: 320 * scrWfactor,
      height: 50 * scrHfactor,
      child: DropdownButtonFormField<String>(
        dropdownColor: const Color(0xff4cc9f0),
        value: value,
        icon: Container(
          margin: const EdgeInsets.only(top: 5),
          child: const Icon(Icons.arrow_downward),
        ),
        decoration: InputDecoration(
          isCollapsed: false,
          border: const OutlineInputBorder(),
          counterStyle: const TextStyle(color: Colors.transparent),
          counter: const IgnorePointer(),
          fillColor: const Color(0xff4cc9f0),
          filled: true,
          hintText: widget.text,
          hintStyle: const TextStyle(
            fontFamily: "montserrat",
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        items: widget.itemList.map(buildMenuItem).toList(),
        onChanged: (changedValue) => setState(() {
          value = changedValue;
        }),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(
            fontFamily: "montserrat",
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
}
