import 'package:flutter/material.dart';

Future<bool?> showDialogBox(
  BuildContext context,
  String title,
  String content,
) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      final textStyle = TextStyle(
        color: Theme.of(context).colorScheme.inversePrimary,
      );
      return AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(title, style: textStyle),
        content: Text(content, style: textStyle),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text("Cancel", style: textStyle),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text("Ok", style: textStyle),
          ),
        ],
      );
    },
  );
}
