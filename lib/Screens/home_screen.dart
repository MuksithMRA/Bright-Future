import 'package:brightfuture/constant/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/screen_size.dart';
import '../Providers/home_screen_controller.dart';
import '../Services/Database/post_handeling.dart';
import '../Widgets/Custom Text Field/custom_textfield.dart';
import '../Widgets/CustomText/custom_text.dart';
import '../Widgets/Post Widget/post_widget.dart';
import '../Widgets/loading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final ctrl = Provider.of<HomeScreenController>(context, listen: false);
    ctrl.loadAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenController>(
      builder: (context, ctrl, child) {
        return SizedBox(
          height: ScreenSize.height,
          child: Column(
            children: [
              SizedBox(
                height: ScreenSize.height * 0.03,
              ),
              PostSearchTextField(
                ctrl: ctrl,
              ),
              SizedBox(
                height: ScreenSize.height * 0.01,
              ),
              const ChipSet(),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: PostHandling.getPosts(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: CustomText(title: "Something went wrong"),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const LoadingWidget();
                    }

                    ctrl.loadPosts(snapshot);
                    if (ctrl.foundData.isNotEmpty) {
                      return ListView.builder(
                        itemCount: ctrl.foundData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return EntirePost(
                            post: ctrl.foundData[index].post,
                            ref: ctrl.foundData[index].ref,
                          );
                        },
                      );
                    } else {
                      return const Align(
                          alignment: Alignment.center,
                          child: CustomText(title: "No search result found !"));
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ChipSet extends StatelessWidget {
  const ChipSet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenController>(
      builder: (context, ctrl, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                ctrl.chipOnClick(null);
              },
              child: Chip(
                label: const CustomText(title: 'All Posts'),
                labelStyle: TextStyle(color: kWhite),
                elevation: 3,
                backgroundColor: primaryColor,
              ),
            ),
            SizedBox(
              width: ScreenSize.width * 0.01,
            ),
            InkWell(
              onTap: () {
                ctrl.chipOnClick("Claim");
              },
              child: Chip(
                label: const CustomText(title: 'Claim Posts'),
                labelStyle: TextStyle(color: kWhite),
                elevation: 3,
                backgroundColor: primaryColor,
              ),
            ),
            SizedBox(
              width: ScreenSize.width * 0.01,
            ),
            InkWell(
              onTap: () {
                ctrl.chipOnClick("Offer");
              },
              child: Chip(
                  backgroundColor: primaryColor,
                  labelStyle: TextStyle(color: kWhite),
                  label: const CustomText(
                    title: 'Offer Posts',
                  ),
                  elevation: 3),
            )
          ],
        );
      },
    );
  }
}

class PostSearchTextField extends StatelessWidget {
  final HomeScreenController ctrl;
  const PostSearchTextField({Key? key, required this.ctrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.width * 0.03,
      ),
      child: CustomTextField(
        onChanged: (String? searchText) {
          ctrl.searchPosts(searchText);
        },
        prefixIcon: const Icon(Icons.search),
        hintText: 'Search by user name',
        borderSide: BorderSide.none,
        radius: ScreenSize.width * 0.5,
        filled: true,
        fillColor: const Color(0xffeeeeee),
      ),
    );
  }
}
