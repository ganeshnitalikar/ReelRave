import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ree_rave/constant.dart';
import 'package:ree_rave/models/user_model.dart';

class MySearchController extends GetxController {
  final Rx<List<User>> _searchResult = Rx<List<User>>([]);
  List<User> get searchResult => _searchResult.value;

  searchUser(String query) {
    _searchResult.bindStream(firestore
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: query)
        .orderBy('name', descending: false)
        .snapshots()
        .map((QuerySnapshot query) {
      List<User> retVal = [];
      for (var element in query.docs) {
        retVal.add(User.fromSnap(element));
      }
      return retVal;
    }));
  }
}
