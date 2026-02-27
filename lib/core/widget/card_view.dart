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
  final double cardWidth;
  final double cardHeight;

  final double width;
  final double height;
  final Function(String)? onTextChanged;


  final TextStyle? textStyle;
  final TextStyle? subtitleStyle;

  const ProfileInfoCard({
    super.key,
    required this.text,
    required this.cardWidth,
    required this.cardHeight,
    this.text2,
    required this.imageLeft,
    this.imageRight,
    this.onTapRight,
    this.onTap,
    this.showCopyIcon = false,
    this.onTextChanged,
    required this.width,
    required this.height,
    this.textStyle,
    this.subtitleStyle,
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
    return SizedBox(
      width: widget.cardWidth,
      height: widget.cardHeight,
      child: Card(
        child: InkWell(
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [

                SizedBox(
                  width: widget.width,
                  height: widget.height,
                  child: Center(
                    child: Image.asset(
                      widget.imageLeft,
                      width: widget.width,
                      height: widget.height,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              
                Expanded(
                  child: isEditing
                      ? Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          autofocus: true,
                          onSubmitted: (_) => _submitEditing(),
                          style: widget.textStyle,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
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
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.text,
                          style: widget.textStyle ??
                              const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black)),
                      if (widget.text2 != null)
                        Text(widget.text2!,
                            style: widget.subtitleStyle ??
                                const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey)),
                    ],
                  ),
                ),
                if (widget.imageRight != null && !isEditing)
                  InkWell(
                    onTap: () {
                      if (widget.imageRight == AppAssets.edit) {
                        _startEditing();
                      } else {
                        if (widget.onTapRight != null) widget.onTapRight!();
                      }
                    },
                    child: Image.asset(widget.imageRight!,
                        width: 35, height: 35),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}