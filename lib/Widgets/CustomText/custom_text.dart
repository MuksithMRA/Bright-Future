import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String title;
  final FontWeight? fontWeight;
  final Color? color;
  final double? fontSize;
  final TextAlign? textAlign;
  final void Function()? onTap;
  const CustomText(
      {Key? key,
      required this.title,
      this.fontWeight,
      this.color,
      this.fontSize,
      this.textAlign,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        title,
        style:
            TextStyle(fontWeight: fontWeight, color: color, fontSize: fontSize),
        textAlign: textAlign,
      ),
    );
  }
}
