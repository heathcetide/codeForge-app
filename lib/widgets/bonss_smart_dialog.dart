import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class CustomDialog {
  static void show(String message) {
    SmartDialog.show(
      builder:
          (_) => AlertDialog(
            title: Text('提示'),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                onPressed: () => SmartDialog.dismiss(),
                child: const Text('确定'),
              ),
            ],
          ),
    );
  }
}
