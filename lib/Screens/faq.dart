import 'package:brightfuture/Models/faq.dart';
import 'package:brightfuture/Providers/faq_controller.dart';
import 'package:brightfuture/Providers/validations.dart';
import 'package:brightfuture/Widgets/Custom%20Button/custom_button.dart';
import 'package:brightfuture/Widgets/Custom%20Text%20Field/custom_textfield.dart';
import 'package:brightfuture/Widgets/loading.dart';
import 'package:brightfuture/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/screen_size.dart';
import '../Models/user_data.dart';
import '../Widgets/CustomText/custom_text.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<FAQ> faqList = Provider.of<List<FAQ>>(context);
    return SafeArea(
      child: Scaffold(
        
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => showModalBottomSheet(
            context: context,
            builder: (_) => const AddFaq(),
          ),
          label: const CustomText(title: "Submit your Question"),
          icon: const Icon(Icons.chat),
        ),
        body: SizedBox(
          height: ScreenSize.height * 0.9,
          width: ScreenSize.width,
          child: Column(
            children: [
              const Align(alignment: Alignment.topLeft, child: BackButton()),
              const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: CustomText(
                      title: "Frequently Asked Questions",
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                  )),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenSize.width * 0.02,
                      vertical: ScreenSize.height * 0.01),
                  itemCount: faqList.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (faqList.isEmpty) {
                      return const LoadingWidget();
                    }
                    FAQ faq = faqList[index];
                    return FAQTile(faq: faq);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FAQTile extends StatelessWidget {
  final FAQ faq;
  const FAQTile({Key? key, required this.faq}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.quiz_rounded,
                color: primaryColor,
              ),
              title: CustomText(
                title: faq.title,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: ScreenSize.height * 0.01,
            ),
            CustomText(title: faq.subtitle),
            SizedBox(
              height: ScreenSize.height * 0.01,
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: primaryColor,
              ),
              title: const CustomText(title: "Asked By "),
              subtitle: CustomText(title: "${faq.userData?['fullName']}"),
            )
          ],
        ),
      ),
    );
  }
}

class AddFaq extends StatefulWidget {
  const AddFaq({Key? key}) : super(key: key);

  @override
  State<AddFaq> createState() => _AddFaqState();
}

class _AddFaqState extends State<AddFaq> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    List<UserData>? users = FAQController.loadUsers(context);
    return Consumer<FAQController>(
      builder: (context, ctrl, child) {
        return Form(
          key: _formKey,
          child: SizedBox(
            height: ScreenSize.height * 0.3,
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.08),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomTextField(
                    validator: (String? val) {
                      return ValidationController.commonValidator(
                          val, "Quiz cannot be empty");
                    },
                    onChanged: (String? quiz) {
                      ctrl.setQuiz(quiz);
                    },
                    prefixIcon: const Icon(Icons.quiz),
                    hintText: 'Write a Question',
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (users != null) {
                              ctrl.createFaq(context, users);
                            }
                          }
                        },
                        label: "Ask",
                        height: ScreenSize.height * 0.06,
                        minWidth: ScreenSize.width * 0.5,
                        radius: 30,
                      ),
                      FloatingActionButton.small(
                        backgroundColor: Colors.red,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.close,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
