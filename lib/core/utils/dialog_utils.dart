import 'package:flutter/material.dart';
import 'package:flutter_animation/core/src/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../widgets/staless/primary_button.dart';
import '../../widgets/staless/spacer.dart';
import 'utils_helper.dart';

class DialogUtils {
  DialogUtils._();

  static void showToast(String msg) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: msg,
      textColor: AppColors.white,
      backgroundColor: AppColors.grey.withOpacity(0.8),
    );
  }

  static Future<void> showPrimaryDialog({
    String? label,
    String message = 'none',
    String? confirmText,
    String? cancelText,
    VoidCallback? onClose,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    Widget? child,
    bool closeWhenAction = true,
    bool barrierDismissible = false,
  }) {
    final context = UtilsHelper.navigatorKey.currentContext;
    if (context == null) {
      return Future.value();
    }

    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible, // user must tap button!
      builder: (BuildContext context) {
        void back() {
          if (closeWhenAction) {
            dismissPopup();
          }
        }

        return AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: const EdgeInsets.all(0),
          content: PrimaryDialog(
            label: label ?? 'Alert',
            message: message,
            cancelLabel: cancelText ?? 'Cancel',
            confirmLabel: confirmText ?? 'Confirm',
            onClose: onClose != null
                ? () {
                    onClose();
                    dismissPopup();
                  }
                : null,
            onCancel: onCancel != null
                ? () {
                    onCancel();
                    back();
                  }
                : null,
            onConfirm: onConfirm != null
                ? () {
                    onConfirm();
                    back();
                  }
                : null,
            child: child,
          ),
        );
      },
    );
  }

  static void showBottomSheetDialog(
      {Widget? child,
      double? height,
      VoidCallback? onClose,
      bool enableDrag = true,
      bool dismissible = true,
      bool isRounded = false,
      bool isPushAllViewOnKeyBoard = false}) async {
    try {
      final context = UtilsHelper.navigatorKey.currentContext!;

      double top = MediaQuery.of(context).padding.top;
      double maxHeight = MediaQuery.of(context).size.height - top;
      await showModalBottomSheet(
        context: context,
        enableDrag: enableDrag,
        isDismissible: dismissible,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
          padding: isPushAllViewOnKeyBoard ? MediaQuery.of(context).viewInsets : EdgeInsets.zero,
          constraints: BoxConstraints(minHeight: height ?? 0, maxHeight: maxHeight),
          // height: height,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: isRounded
                ? const BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  )
                : BorderRadius.zero,
          ),
          child: child,
        ),
      );
      if (onClose != null) onClose();
    } catch (e) {
      // print(e);
    }
  }

  static dismissPopup() {
    UtilsHelper.pop();
  }
}

class PrimaryDialog extends StatelessWidget {
  const PrimaryDialog(
      {Key? key,
      this.onConfirm,
      this.onCancel,
      this.onClose,
      this.label = 'Alert',
      this.message = '',
      this.confirmLabel = 'Confirm',
      this.cancelLabel = 'Cancel',
      this.child})
      : super(key: key);

  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final VoidCallback? onClose;

  final String label;
  final String message;
  final String confirmLabel;
  final String cancelLabel;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final List<Widget> actions = [];

    if (onCancel != null) {
      actions.add(
        PrimaryButton(
          onPress: onCancel ?? () {},
          label: cancelLabel,
          color: Colors.white,
          textColor: AppColors.red,
          borderColor: AppColors.red,
          width: onConfirm == null ? width * 0.4 : 100,
        ),
      );
    }

    if (onConfirm != null) {
      actions.add(PrimaryButton(
        onPress: onConfirm ?? () {},
        label: confirmLabel,
        borderColor: AppColors.green,
        width: onConfirm == null ? width * 0.4 : 100,
      ));
    }
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Wrap(children: <Widget>[
          Container(
            // height: height*0.25,
            padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: width * 0.08),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            constraints: BoxConstraints(
              minHeight: height * 0.25,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //title
                Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SpaceVertical(),
                // message
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                // button
                const SpaceVertical(),
                child ?? Container(),
                if (child != null) const SpaceVertical(),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  runSpacing: 10,
                  children: actions,
                )
              ],
            ),
          ),
        ]),
        Positioned(
            //top: -width * 0.05,
            right: 0,
            child: onClose != null ? IconButton(onPressed: onClose, icon: const Icon(Icons.close)) : Container()),
      ],
    );
  }
}
