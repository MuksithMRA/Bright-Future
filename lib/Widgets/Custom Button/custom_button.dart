import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  final double radius;
  final String label;
  final double height;
  final double minWidth;
  final void Function()? onPressed;
  const CustomButton({
    Key? key,
    required this.label,
    required this.height,
    required this.minWidth,
    required this.radius,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(radius),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
        height: height,
        minWidth: minWidth,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: onPressed,
      ),
    );
  }
}