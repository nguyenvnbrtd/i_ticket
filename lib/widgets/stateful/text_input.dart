import 'package:flutter/material.dart';

import '../../../../../../core/src/app_colors.dart';
import '../../../../../../core/src/assets.dart';

class TextInput extends StatefulWidget {
  TextInput(
      {Key? key,
      required this.controller,
      this.hint = '',
      this.imageFront,
      this.imageBack,
      this.onImageFrontPress,
      this.onImageBackPress,
      this.onTextChange,
      this.borderWidth = 0,
      this.borderColor = Colors.black,
      this.secureText = false})
      : super(key: key);

  final TextEditingController controller;
  final String hint;
  final String? imageFront;
  final String? imageBack;
  final VoidCallback? onImageFrontPress;
  final VoidCallback? onImageBackPress;
  final Function(String value)? onTextChange;
  final double borderWidth;
  final Color borderColor;
  bool secureText;

  @override
  State<StatefulWidget> createState() => _TextInput();
}

class _TextInput extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: widget.borderWidth == 0 ? Colors.transparent : widget.borderColor,
          width: widget.borderWidth,
        ),
      ),
      child: Row(
        children: [
          if (widget.imageFront != null) InputImageButton(image: widget.imageFront!, onPress: widget.onImageFrontPress),
          Expanded(
            child: TextField(
              controller: widget.controller,
              onChanged: widget.onTextChange,
              style: TextStyle(color: AppColors.textLabel, fontSize: 16),
              obscureText: widget.secureText,
              enableSuggestions: !widget.secureText,
              autocorrect: !widget.secureText,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                hintText: widget.hint,
                hintStyle: TextStyle(color: AppColors.greyMedium, fontSize: 16),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                prefixIconConstraints: const BoxConstraints(maxWidth: 20, maxHeight: 20),
              ),
            ),
          ),
          Visibility(
            visible: widget.imageBack != null,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InputImageButton(
                image: widget.imageBack ?? '',
                color: widget.secureText ? null : AppColors.textLabel,
                onPress: widget.onImageBackPress ?? () {
                  widget.secureText = !widget.secureText;
                  setState(() {});
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class InputImageButton extends StatelessWidget {
  const InputImageButton({Key? key, required this.image, this.onPress, this.color}) : super(key: key);

  final String image;
  final VoidCallback? onPress;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress ?? () {},
      child: SizedBox(
        child: Image.asset(image, color: color ?? AppColors.lightGrey),
        width: 20,
        height: 20,
      ),
    );
  }
}
