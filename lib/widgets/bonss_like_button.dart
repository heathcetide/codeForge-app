import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class CustomLikeButton extends StatelessWidget {
  final bool isLiked;
  final ValueChanged<bool> onTap;

  const CustomLikeButton({Key? key, required this.isLiked, required this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LikeButton(
      isLiked: isLiked,
      onTap: (bool isLiked) async {
        onTap(!isLiked);
        return !isLiked;
      },
    );
  }
}
