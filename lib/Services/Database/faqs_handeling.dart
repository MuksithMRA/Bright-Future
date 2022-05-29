import 'package:brightfuture/Models/faq.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FAQsHandeling {
  static CollectionReference faqs =
      FirebaseFirestore.instance.collection("FAQs");

  static Stream<List<FAQ>> listOfFaqs({String? uid, String? postType}) {
    return faqs.snapshots().map((QuerySnapshot snapshot) => snapshot.docs
        .map((DocumentSnapshot snapshot) =>
            FAQ.fromMap(snapshot.data() as Map<String, dynamic>))
        .toList());
  }

  static createFaq(FAQ faq) async {
    await faqs.add(faq.toMap());
  }
}
