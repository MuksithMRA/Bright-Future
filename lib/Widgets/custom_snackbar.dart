import 'package:flutter/material.dart';
import '../constant/colors.dart';
import 'CustomText/custom_text.dart';

showSnackBar(
    {required bool isError,
    required String message,
    required BuildContext ctx}) {
  SnackBar snackBar = SnackBar(
      action: SnackBarAction(
          textColor: kWhite,
          label: 'Close',
          onPressed: () {
            SnackBarClosedReason.action;
          }),
      backgroundColor: isError ? Colors.red : kWhite,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            isError ? Icons.error : Icons.done,
            color: kWhite,
          ),
          CustomText(
            title: message,
            color: kWhite,
          ),
        ],
      ));
  ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
}
