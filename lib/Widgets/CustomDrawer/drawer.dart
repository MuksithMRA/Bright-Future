import 'package:brightfuture/Models/screen_size.dart';
import 'package:brightfuture/Widgets/CustomText/custom_text.dart';
import 'package:brightfuture/constant/colors.dart';
import 'package:brightfuture/constant/image.dart';
import 'package:flutter/material.dart';
import 'drawer_tiles.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return Drawer(
      child: ListView(
        children: [
          SizedBox(
            height: ScreenSize.height * 0.33,
            child: UserAccountsDrawerHeader(
              currentAccountPictureSize: const Size.fromRadius(75),
              currentAccountPicture: CircleAvatar(
                backgroundImage: const AssetImage(logo),
                backgroundColor: kWhite,
              ),
              decoration: BoxDecoration(color: kWhite),
              accountName: CustomText(
                color: kBlack,
                title: "Bright Future",
                fontSize: 30,
              ),
              accountEmail: CustomText(
                color: primaryColor,
                title: "#1 Easy & User Friendly App",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const DrawerTiles(),
        ],
      ),
    );
  }
}
