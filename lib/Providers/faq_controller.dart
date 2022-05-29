
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../Models/faq.dart';
import '../Models/user_data.dart';
import '../Services/Database/faqs_handeling.dart';
import '../Widgets/custom_snackbar.dart';
import '../Widgets/loading_dialog.dart';

class FAQController extends ChangeNotifier {
  String? quiz;

  setQuiz(String? quiz) {
    this.quiz = quiz;
    notifyListeners();
  }

  createFaq(BuildContext context, List<UserData> user) {
    try {
      showLoaderDialog(context);

      FAQsHandeling.createFaq(FAQ(
          title: quiz ?? '',
          subtitle: "Not Answered yet",
          userData: user[0].toMap()));
      Navigator.pop(context);
      Navigator.pop(context);
      quiz = null;
      notifyListeners();
    } on Exception {
      Navigator.pop(context);
      showSnackBar(isError: true, message: "Error Adding", ctx: context);
    }
  }

  static List<UserData>? loadUsers(BuildContext context) {
    try {
      return Provider.of<List<UserData>>(context);
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
