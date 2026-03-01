// import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';
//
// import 'package:flutter/material.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// Future<void> _saveImage() async {
//   var status = await Permission.photos.request();
//
//   if (!status.isGranted) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Permission denied ❌")),
//     );
//     return;
//   }
//
//   Uint8List? image = await screenshotController.capture(
//     pixelRatio: 3,
//   );
//
//   if (image == null) return;
//
//   final result = await ImageGallerySaver.saveImage(
//     image,
//     quality: 100,
//     name: "cv_${DateTime.now().millisecondsSinceEpoch}",
//   );
//
//   if (result['isSuccess'] == true) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Saved to Gallery ✅")),
//     );
//   }
// }