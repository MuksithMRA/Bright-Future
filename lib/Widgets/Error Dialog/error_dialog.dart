import 'package:brightfuture/Models/screen_size.dart';
import 'package:brightfuture/Widgets/Custom%20Button/custom_button.dart';
import 'package:brightfuture/Widgets/CustomText/custom_text.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String errorText;
  const ErrorDialog({Key? key, required this.errorText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: CustomText(title: "Error")),
      content: CustomText(
        title: errorText,
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        CustomButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop('dialog');
          },
          label: "Close",
          height: 50,
          minWidth: ScreenSize.width * 0.6,
          radius: 15,
        ),
      ],
    );
  }
}
