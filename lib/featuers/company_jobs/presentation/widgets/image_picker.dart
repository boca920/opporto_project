import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();


  Future<File?> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 500,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
    return null;
  }

  // دالة لإظهار القائمة الاختيارية (BottomSheet) بشكل جاهز
  void showImageSourceDialog(BuildContext context, Function(File) onImageSelected) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("Choose Profile Picture",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Color(0xFF3730A3)),
              title: const Text('Gallery'),
              onTap: () async {
                Navigator.pop(context);
                final file = await pickImage(ImageSource.gallery);
                if (file != null) onImageSelected(file);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Color(0xFF3730A3)),
              title: const Text('Camera'),
              onTap: () async {
                Navigator.pop(context);
                final file = await pickImage(ImageSource.camera);
                if (file != null) onImageSelected(file);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}