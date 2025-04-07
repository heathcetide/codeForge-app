// lib/pages/profile/profile.dart
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('个人中心')),
      body: Center(child: Text('这是个人中心页面')),
    );
  }
}
