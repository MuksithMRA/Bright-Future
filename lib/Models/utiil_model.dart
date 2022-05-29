import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class UtilModel {
  static timeStampToString(Timestamp timestamp) {
    final f = DateFormat('yyyy-MM-dd hh:mm');
    return f.format(timestamp.toDate());
  }
}
