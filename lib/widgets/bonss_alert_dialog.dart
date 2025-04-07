import 'package:flutter/material.dart';

class CustomGetWidgetAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;

  const CustomGetWidgetAlertDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
