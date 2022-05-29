import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Animations/page_transition_slide.dart';
import '../Providers/bottom_nav.dart';
import '../Providers/drawer_tile_change.dart';
import '../Providers/profile_screen_controller.dart';
import '../Widgets/Custom App Bar/custom_app_bar.dart';
import '../Widgets/CustomDrawer/drawer.dart';
import '../Widgets/CustomText/custom_text.dart';
import 'add_post.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    Provider.of<DrawerTileChange>(context, listen: false)
        .drawerTileData[0]
        .isTapped = true;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNav>(
      builder: (context, bnav, child) {
        return Scaffold(
          drawer: const CustomDrawer(),
          floatingActionButton: CustomFloatingActionButton(
            bNav: bnav,
          ),
          appBar: customAppBar(
              title: bnav.navItems[bnav.currentIndex].label, context: context),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: bnav.currentIndex,
            items: bnav.navItems.map((e) {
              return BottomNavigationBarItem(
                  icon: Icon(e.icon), label: e.label);
            }).toList(),
            onTap: (val) {
              bnav.onChange(val);
            },
          ),
          body: bnav.navItems[bnav.currentIndex].route,
        );
      },
    );
  }
}

class CustomFloatingActionButton extends StatelessWidget {
  final dynamic bNav;
  const CustomFloatingActionButton({Key? key, this.bNav}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bNav.currentIndex == 1
        ? const SizedBox()
        : FloatingActionButton.extended(
            label: const CustomText(title: "Add a Post"),
            onPressed: () {
              Navigator.push(
                  context,
                  SlideTransition1(const ManagePost(
                    isAdd: true,
                  )));
            },
            icon: const Icon(Icons.post_add),
          );
  }
}

class CallButton extends StatelessWidget {
  const CallButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
       
      },
      child: const Icon(Icons.phone),
    );
  }
}
