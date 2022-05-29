import 'package:cross_file_image/cross_file_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../Models/screen_size.dart';
import '../../Providers/manage_post_controller.dart';

class AddImages extends StatelessWidget {
  const AddImages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ManagePostController>(
      builder: (context, ctrl, child) {
        return SizedBox(
          height: ScreenSize.height * 0.3,
          width: ScreenSize.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ImageBox(ctrl: ctrl, imgName: "Image1"),
              ImageBox(ctrl: ctrl, imgName: "Image2"),
            ],
          ),
        );
      },
    );
  }
}

class ImageBox extends StatelessWidget {
  final ManagePostController ctrl;
  final String imgName;
  const ImageBox({Key? key, required this.ctrl, required this.imgName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await ctrl.pickImage(imgName, context);
      },
      child: Material(
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            image: ctrl.images[imgName] != null
                ? DecorationImage(
                    image: XFileImage(ctrl.images[imgName] as XFile))
                : null,
          ),
          child: ctrl.images[imgName] == null
              ? const Center(
                  child: Icon(Icons.add_a_photo),
                )
              : null,
          width: ScreenSize.width * 0.4,
          height: ScreenSize.height * 0.3,
        ),
      ),
    );
  }
}
