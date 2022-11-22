import 'package:flutter/material.dart';
import 'primary_button.dart';
import 'spacer.dart';

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
        SizedBox(
          width: onConfirm == null ? width * 0.4 : 100,
          child: PrimaryButton(
            onPress: onCancel ?? () {},
            label: cancelLabel,
            color: Colors.white,
            textColor: Colors.black45,
          ),
        ),
      );
    }

    if (onConfirm != null) {
      actions.add(SizedBox(
        width: onCancel == null ? width * 0.4 : 100,
        child: PrimaryButton(
          onPress: onConfirm ?? () {},
          label: confirmLabel,
        ),
      ));
    }
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Wrap(
            children: <Widget>[
              Container(
                // height: height*0.25,
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05, vertical: width * 0.08),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: BoxConstraints(
                  minHeight: height*0.25,

                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //title
                    Text(
                      label,
                      style:
                      const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                    if(child != null) const SpaceVertical() ,
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
            child: onClose != null
                ? IconButton(onPressed: onClose, icon: const Icon(Icons.close))
                : Container()),
      ],
    );
  }
}
