

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PostQuote {
  static Future<void> createPost(Map<String, dynamic> quoteData) async {
    try {
      EasyLoading.show(status: 'creating post...');
      await FirebaseFirestore.instance.collection('quotes').add(quoteData);
      EasyLoading.showSuccess("Quote posted successfully");
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.showError("Failed to post quote: $e");
    }
  }
}