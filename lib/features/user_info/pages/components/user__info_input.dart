import 'package:flutter/material.dart';
import 'package:flutter_animation/core/src/app_colors.dart';
import 'package:flutter_animation/widgets/staless/spacer.dart';

class UserInfoInput extends StatefulWidget {
  final TextEditingController? controller;
  final String title;
  final String hint;
  final ValueChanged<String>? onChanged;

  const UserInfoInput({Key? key, this.controller, this.title = 'none', this.hint = 'none', this.onChanged})
      : super(key: key);

  @override
  State<UserInfoInput> createState() => _UserInfoInputState();
}

class _UserInfoInputState extends State<UserInfoInput> {
  late final TextEditingController controller;

  bool hasData = false;

  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
    if (controller.text.isNotEmpty) hasData = true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SpaceVertical(height: 10),
        Text(
          widget.title,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: hasData ? AppColors.grey : null,
            fontWeight: hasData ? null : FontWeight.w500,
          ),
        ),
        TextField(
          controller: controller,
          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 18),
          onChanged: onTextChange,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: widget.hint,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500, color: AppColors.textHint),
          ),
        ),
      ],
    );
  }

  void onTextChange(String value) {
    if (value.isEmpty) {
      setState(() {
        hasData = false;
      });
    } else {
      if (hasData) return;
      setState(() {
        hasData = true;
      });
    }
    if (widget.onChanged != null) widget.onChanged!(value);
  }
}
