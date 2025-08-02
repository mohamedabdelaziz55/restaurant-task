import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../features/home/data/models/home_model/product_model.dart';



class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ProductModel>> getAllProducts() async {
    final snapshot = await _firestore.collection('items').orderBy('createdAt', descending: true).get();
    return snapshot.docs.map((doc) => ProductModel.fromFirestore(doc.data(), doc.id)).toList();
  }
}
class ItemDatabaseService {
  final _firestore = FirebaseFirestore.instance;

  Future<void> addItem(Map<String, dynamic> itemData) async {
    await _firestore.collection('items').add(itemData);
  }
}

class DatabaseMethods {
  Future<void> addUserDetails(Map<String, dynamic> userInfoMap, String id) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .set(userInfoMap);
  }

  Future<void> upDataUserWallet(String id, String walletValue) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .update({"Wallet": walletValue});
  }
}
