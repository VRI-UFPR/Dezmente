import 'package:flutter/material.dart';

showAlertDialog(
    {required BuildContext context,
    String? titleText,
    String? contentText,
    required Function callback}) {
  // set up the buttons

  TextStyle textStyle = const TextStyle(color: Color(0xff060607));

  ButtonStyle buttonStyle = TextButton.styleFrom(
    backgroundColor: Colors.white.withOpacity(0.6),
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
    minimumSize: const Size(0, 0),
  );

  Widget simButton = TextButton(
      style: buttonStyle,
      onPressed: () {
        Navigator.of(context).pop();
        callback();
      },
      child: Text("Sim", style: textStyle));

  Widget naoButton = TextButton(
      style: buttonStyle,
      onPressed: () => Navigator.of(context).pop(),
      child: Text("Não", style: textStyle));

  Widget title = Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: Color(0xffe984b8),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5.0),
            topRight: Radius.circular(5.0),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black, blurRadius: 0.8),
          ]),
      child: titleText != null
          ? Text(titleText, textAlign: TextAlign.center)
          : null);

  AlertDialog alert = AlertDialog(
    titlePadding: const EdgeInsets.all(0),
    titleTextStyle:
        textStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
    contentPadding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
    actionsAlignment: MainAxisAlignment.center,
    backgroundColor: const Color.fromARGB(255, 230, 139, 186),
    content: (contentText != null)
        ? Text(contentText,
            style: textStyle.copyWith(fontWeight: FontWeight.w500))
        : null,
    title: title,
    actions: [
      simButton,
      const SizedBox(
        width: 10,
      ),
      naoButton,
    ],
  ); // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}


