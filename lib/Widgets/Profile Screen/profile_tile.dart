import 'package:flutter/material.dart';
import '../Edit Dialog/edit_dialog.dart';

class ProfileListTile extends StatelessWidget {
  final IconData leading;
  final String title;
  final FontWeight? fontWeight;
  final double? fontSize;
  final String subtitle;
  const ProfileListTile(
      {Key? key,
      required this.title,
      this.fontWeight,
      this.fontSize,
      this.subtitle = '',
      required this.leading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        leading,
        color: Theme.of(context).primaryColor,
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: fontWeight, fontSize: fontSize),
      ),
      subtitle: Text(subtitle),
      trailing:title == "Email"?null: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) {
                return EditDialog(
                  what: title,
                  content: subtitle,
                );
              },
            );
          },
          icon: const Icon(Icons.edit)),
    );
  }
}
