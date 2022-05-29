import 'package:brightfuture/Providers/profile_screen_controller.dart';
import 'package:brightfuture/Widgets/loading.dart';
import 'package:brightfuture/constant/image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Models/screen_size.dart';
import '../Custom Button/custom_button.dart';
import '../Custom Text Field/custom_textfield.dart';
import '../CustomText/custom_text.dart';

class EditDialog extends StatelessWidget {
  final String what;
  final String content;

  const EditDialog({Key? key, required this.what, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileScreenController>(
      builder: (context, ctrl, child) {
        return AlertDialog(
          title: Center(
            child: CustomText(title: "Edit $what"),
          ),
          content: SizedBox(
            height: ScreenSize.height * 0.5,
            width: ScreenSize.width,
            child: Column(
              children: [
                Expanded(flex: 2, child: Image.asset(editImg)),
                ctrl.isLoading
                    ? const LoadingWidget()
                    : Expanded(
                        child: CustomTextField(
                          onChanged: (val) {
                            ctrl.setUpdatedData(val);
                          },
                          initialValue: content,
                          label: what,
                          isPassword: false,
                        ),
                      ),
              ],
            ),
          ),
          actions: [
            CustomButton(
              label: "Update",
              height: ScreenSize.height * 0.05,
              minWidth: ScreenSize.width * 0.3,
              radius: 20,
              onPressed: () async {
                ctrl.setOnLoad(true);
                await ctrl.update(what, context);
                ctrl.setOnLoad(false);
              },
            ),
            CustomButton(
              label: "Cancel",
              height: ScreenSize.height * 0.05,
              minWidth: ScreenSize.width * 0.3,
              radius: 20,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
