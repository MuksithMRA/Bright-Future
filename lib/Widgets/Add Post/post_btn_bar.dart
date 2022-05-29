
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Models/screen_size.dart';
import '../../Providers/manage_post_controller.dart';
import '../../Providers/google_map_controller.dart';
import '../../Providers/my_post_controller.dart';
import '../Custom Button/custom_button.dart';
import '../custom_snackbar.dart';

class PostButtonBar extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const PostButtonBar({Key? key, required this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ManagePostController>(
      builder: (context, ctrl, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    final String address =
                        Provider.of<GoogleMapCtrl>(context, listen: false)
                            .address;

                    ctrl.setPostType(
                        Provider.of<MyPostController>(context, listen: false)
                            .dropdownvalue);
                    if (ctrl.images.isEmpty) {
                      showSnackBar(
                          isError: true,
                          message: "please add at least one image",
                          ctx: context);
                    } else if (address == "Add location") {
                      showSnackBar(
                          isError: true,
                          message: "please add your location",
                          ctx: context);
                    } else {
                      await ctrl.createPost(context);
                      Provider.of<GoogleMapCtrl>(context, listen: false)
                          .setAddressDefault();

                      ctrl.clearImageArray();
                    }
                  }
                },
                label: "Add Post",
                height: 50,
                minWidth: ScreenSize.width * 0.85,
                radius: 20),
          ],
        );
      },
    );
  }
}
