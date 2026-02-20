import 'package:flutter/material.dart';

class ProfileInfoCard extends StatelessWidget {
  final String text;
  final String? text2;
  final String imageLeft;
  final String? imageRight;
  final bool showCopyIcon;
  final VoidCallback? onTapRight;
  final VoidCallback? onTap;

  final Function(String)? onTextChanged;

  const ProfileInfoCard({
    super.key,
    required this.text,
    this.text2,
    required this.imageLeft,
    this.imageRight,
    this.onTapRight,
    this.onTap,
    this.showCopyIcon = false,
    this.onTextChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: Image.asset(imageLeft, width: 30, height: 30),
        title: Text(text),
        subtitle: text2 != null ? Text(text2!) : null,
        trailing: imageRight != null
            ? InkWell(
          onTap: onTapRight,
          child: Image.asset(imageRight!, width: 25, height: 25),
        )
            : null,
      ),
    );
  }
}