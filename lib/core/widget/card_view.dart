import 'package:flutter/material.dart';
import '../utils/app_fonts.dart';

class ProfileInfoCard extends StatefulWidget {
  final String text;                  // النص الأساسي
  final String? text2;                // نص ثانوي اختياري
  final String imageLeft;             // صورة يسار
  final String? imageRight;           // صورة يمين اختياري
  final void Function(String)? onTextChanged; // callback لتحديث النص في الخارج

  const ProfileInfoCard({
    super.key,
    required this.text,
    required this.imageLeft,
    this.text2,
    this.imageRight,
    this.onTextChanged,
  });

  @override
  State<ProfileInfoCard> createState() => _ProfileInfoCardState();
}

class _ProfileInfoCardState extends State<ProfileInfoCard> {
  late String mainText;

  @override
  void initState() {
    super.initState();
    mainText = widget.text;
  }

  // دالة تعديل النص
  void _editText() async {
    TextEditingController controller = TextEditingController(text: mainText);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Text'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Enter new text',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                mainText = controller.text;
              });
              if (widget.onTextChanged != null) {
                widget.onTextChanged!(mainText); // تحديث النص في الخارج
              }
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    bool hasSecondText = widget.text2 != null && widget.text2!.trim().isNotEmpty;
    bool hasRightImage = widget.imageRight != null && widget.imageRight!.trim().isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: height * 0.005,
        horizontal: width * 0.02,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: hasSecondText
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [

              // الصورة اليسرى دائرية
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: ClipOval(
                  child: Image.asset(
                    widget.imageLeft,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // النصوص
              Expanded(
                child: hasSecondText
                    ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.text2!,
                      style: AppFonts.graybold12,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      mainText,
                      style: AppFonts.blackbold16,
                    ),
                  ],
                )
                    : Text(
                  mainText,
                  style: AppFonts.blackbold16,
                ),
              ),

              // الصورة اليمنى دائرية وقابلة للتعديل
              if (hasRightImage) ...[
                const SizedBox(width: 10),
                InkWell(
                  onTap: _editText,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        widget.imageRight!,
                        fit: BoxFit.cover,
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
