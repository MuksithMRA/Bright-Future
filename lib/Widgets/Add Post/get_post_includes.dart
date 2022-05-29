import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/screen_size.dart';
import '../../Providers/manage_post_controller.dart';
import '../Custom Text Field/custom_textfield.dart';

class GetPostIncludes extends StatelessWidget {
  const GetPostIncludes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ManagePostController>(
      builder: (context, ctrl, child) {
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: ScreenSize.height * 0.03,
            horizontal: ScreenSize.width * 0.05,
          ),
          child: CustomTextField(
            validator: (val) {
              if (val == null || val.length < 50) {
                return "Body must have at least 50 characters ";
              }
              return null;
            },
            onChanged: (String postBody) {
              ctrl.postBodyOnChange(postBody);
            },
            label: "Body",
            isPassword: false,
            maxLines: 8,
            maxLength: 500,
          ),
        );
      },
    );
  }
}
