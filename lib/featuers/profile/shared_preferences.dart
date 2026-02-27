// import 'package:shared_preferences/shared_preferences.dart';
//
// class UserPreferences {
//   static Future<void> saveUserData({
//     required String fullName,
//     required String address,
//     required String phone,
//     required String email,
//   }) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('fullName', fullName);
//     await prefs.setString('address', address);
//     await prefs.setString('phone', phone);
//     await prefs.setString('email', email);
//   }
//
//   static Future<Map<String, String>> getUserData() async {
//     final prefs = await SharedPreferences.getInstance();
//     return {
//       'fullName': prefs.getString('fullName') ?? '',
//       'address': prefs.getString('address') ?? '',
//       'phone': prefs.getString('phone') ?? '',
//       'email': prefs.getString('email') ?? '',
//     };
//   }
// }














import 'package:flutter/material.dart';
import 'package:opporto_project/core/utils/app_assets.dart';

class ProfileInfoCard extends StatefulWidget {
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
  State<ProfileInfoCard> createState() => _ProfileInfoCardState();
}

class _ProfileInfoCardState extends State<ProfileInfoCard> {
  bool isEditing = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startEditing() {
    setState(() {
      isEditing = true;
    });
  }

  void _submitEditing() {
    setState(() {
      isEditing = false;
    });
    if (widget.onTextChanged != null) {
      widget.onTextChanged!(_controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: widget.onTap,
        leading: Image.asset(widget.imageLeft, width: 50, height: 60),
        title: isEditing
            ? Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                autofocus: true,
                onSubmitted: (_) => _submitEditing(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _submitEditing,
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                setState(() {
                  isEditing = false;
                  _controller.text = widget.text;
                });
              },
            ),
          ],
        )
            : Text(widget.text),
        subtitle: widget.text2 != null ? Text(widget.text2!) : null,
        trailing: widget.imageRight != null && !isEditing
            ? InkWell(
          onTap: () {
            if (widget.imageRight == AppAssets.edit) {
              _startEditing();
            } else {
              if (widget.onTapRight != null) widget.onTapRight!();
            }
          },
          child: Image.asset(widget.imageRight!, width: 35, height: 35),
        )
            : null,
      ),
    );
  }
}