import 'package:badges/badges.dart';
import 'package:brightfuture/constant/image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/screen_size.dart';
import '../Models/user_data.dart';
import '../Providers/profile_screen_controller.dart';
import '../Services/Database/user_handeling.dart';
import '../Widgets/CustomText/custom_text.dart';
import '../Widgets/Profile Screen/profile_tile.dart';
import '../Widgets/loading.dart';
import '../constant/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 30, vertical: ScreenSize.height * 0.1),
        child: Material(
          borderRadius: BorderRadius.circular(25),
          elevation: 7,
          color: Colors.white,
          child: StreamBuilder<UserData>(
            stream: UserHandling.getCurrentUserDetails(),
            builder: (context, AsyncSnapshot<UserData> snapshot) {
              if (snapshot.data != null) {
                Provider.of<ProfileScreenController>(context, listen: false)
                    .setUser(snapshot.data);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Badge(
                      badgeContent: InkWell(
                          onTap: () {
                            Provider.of<ProfileScreenController>(context,
                                    listen: false)
                                .uploadImage(context);
                          },
                          child: Icon(
                            Icons.camera_alt,
                            color: kWhite,
                          )),
                      child: CachedNetworkImage(
                        imageUrl: snapshot.data?.photoUrl ?? dp,
                        imageBuilder: (context, imageProvider) => Container(
                          width: ScreenSize.width * 0.3,
                          height: ScreenSize.height * 0.17,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    CustomText(
                      title: snapshot.data?.fullName ?? "Loading..",
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: ScreenSize.height * 0.05,
                    ),
                    Column(
                      children: [
                        ProfileListTile(
                          leading: Icons.person,
                          title: "Name",
                          subtitle: snapshot.data?.fullName ?? "Loading..",
                        ),
                        ProfileListTile(
                          leading: Icons.location_city,
                          title: "City",
                          subtitle: snapshot.data?.city ?? "Loading..",
                        ),
                        ProfileListTile(
                          leading: Icons.mail,
                          title: "Email",
                          subtitle: snapshot.data?.email ?? "Loading..",
                        ),
                        ProfileListTile(
                          leading: Icons.call,
                          title: "Phone Number",
                          subtitle: snapshot.data?.phoneNumber ?? "Loading..",
                        ),
                      ],
                    ),
                  ],
                );
              }
              return const LoadingWidget();
            },
          ),
        ),
      ),
    );
  }
}
