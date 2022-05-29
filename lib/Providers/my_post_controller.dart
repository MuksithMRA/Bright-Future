import 'package:flutter/cupertino.dart';


class MyPostController extends ChangeNotifier {
  String? dropdownvalue = 'Claim';
  var items = [
    'Claim',
    'Offer',
  ];

  setPostType(String? dropdownvalue) {
    this.dropdownvalue = dropdownvalue;
    notifyListeners();
  }

  
}
