import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Models/screen_size.dart';
import '../Widgets/Custom App Bar/custom_app_bar.dart';
import '../Widgets/CustomText/custom_text.dart';
import '../constant/image.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "About us", context: context),
      body: SingleChildScrollView(
        child: SizedBox(
          width: ScreenSize.width,
          height: ScreenSize.height,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: ScreenSize.width * 0.2,
                  child: CircleAvatar(
                    radius: ScreenSize.width * 0.18,
                    backgroundImage: const AssetImage(logo),
                  ),
                ),
                const Card(
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CustomText(
                        title:
                            "The name of the Application is Bright Future. I believe, if all the organizations become connected in event plan making and helping the needy, then helping children or people will become more efficient. People can contact us and we will link them with the perfect platformThe main purpose of this app is to help children in matters of charity. it helps people to know where they can ask for help, where they should give charity, where the charity has already been given, to connect volunteers of different organizations. helping people/children in need is a great deal. a thousand crores of people need help every day. it is not possible to help everyone. but if we come together then it will be possible to help 10 times more people than before. we want to aggregate all those people who want to help others all together in a single platform so that the needy people get help in a more flexible way."),
                  ),
                ),
                const CustomText(title: "Contact us"),
                SizedBox(
                  width: ScreenSize.width * 0.8,
                  child: ButtonBar(
                    alignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        heroTag: 1,
                        backgroundColor: const Color(0xff1877f2),
                        onPressed: () {},
                        child: const Icon(FontAwesomeIcons.facebook),
                      ),
                      FloatingActionButton(
                        heroTag: 2,
                        backgroundColor: const Color(0xffDD2A7B),
                        onPressed: () {},
                        child: const Icon(FontAwesomeIcons.instagram),
                      ),
                      FloatingActionButton(
                        heroTag: 3,
                        backgroundColor: const Color(0xff25D366),
                        onPressed: () {},
                        child: const Icon(FontAwesomeIcons.whatsapp),
                      ),
                      FloatingActionButton(
                        heroTag: 4,
                        backgroundColor: const Color(0xff0E76A8),
                        onPressed: () {},
                        child: const Icon(FontAwesomeIcons.linkedin),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
