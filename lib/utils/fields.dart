import 'package:flutter/material.dart';

class CustomTextInputField extends StatefulWidget {
  final String text;
  final TextInputType kbType;
  final int maxLength;

  const CustomTextInputField({
    Key? key,
    this.text = "",
    this.kbType = TextInputType.text,
    this.maxLength = 10,
  }) : super(key: key);

  @override
  State<CustomTextInputField> createState() => _CustomTextInputFieldState();
}

class _CustomTextInputFieldState extends State<CustomTextInputField> {
  @override
  Widget build(BuildContext context) {
    final double scrHfactor = MediaQuery.of(context).size.height / 640;
    final double scrWfactor = MediaQuery.of(context).size.width / 360;
    TextEditingController controller = TextEditingController();

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: 318 * scrWfactor,
      height: 38 * scrHfactor,
      child: TextFormField(
        controller: controller,
        cursorColor: Colors.transparent,
        style: const TextStyle(
          fontFamily: "montserrat",
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(10, 2, 0, 0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none,
          ),
          counterStyle: const TextStyle(color: Colors.transparent),
          counter: const IgnorePointer(),
          fillColor: const Color(0xAD94C1CF),
          filled: true,
          hintText: widget.text,
          hintStyle: const TextStyle(
            fontFamily: "montserrat",
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black,
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

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: 318 * scrWfactor,
      height: 38 * scrHfactor,
      child: DropdownButtonFormField<String>(
        dropdownColor: const Color(0xff4cc9f0),
        value: value,
        icon: Container(
          margin: const EdgeInsets.only(right: 10),
          child: const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.black,
            size: 30,
          ),
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 10),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none,
          ),
          counterStyle: const TextStyle(color: Colors.transparent),
          counter: const IgnorePointer(),
          fillColor: const Color(0xAD94C1CF),
          filled: true,
          hintText: widget.text,
          hintStyle: const TextStyle(
            fontFamily: "montserrat",
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black,
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
