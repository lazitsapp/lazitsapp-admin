import 'package:flutter/material.dart';

showAlertDialog({
  required BuildContext context,
  required Function onAccept,
  String title = 'Title',
  String content = 'Content',
  String acceptButtonText = 'Continue',
}) {

  // set up the buttons
  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
    },
  );

  Widget continueButton = TextButton(
    child: Text(acceptButtonText),
    onPressed: () => onAccept(),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );

}