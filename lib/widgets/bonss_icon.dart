import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class CustomIcon extends StatelessWidget {
  final IconData icon;

  const CustomIcon({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(icon, size: 30);
  }
}
