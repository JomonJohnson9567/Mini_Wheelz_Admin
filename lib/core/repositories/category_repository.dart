import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mini_wheelz/core/models/category.dart';

class CategoryRepository {
  CategoryRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _col =>
      _firestore.collection('categories');

  Future<List<CategoryModel>> fetchCategories() async {
    final snapshot = await _col.orderBy('createdAt', descending: true).get();
    return snapshot.docs.map((doc) => CategoryModel.fromDocument(doc)).toList();
  }

  Stream<List<CategoryModel>> watchCategories() {
    return _col
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => CategoryModel.fromDocument(doc))
              .toList(),
        );
  }

  Future<void> addCategory({
    required String name,
    required String description,
  }) async {
    await _col.add({
      'name': name,
      'description': description,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
