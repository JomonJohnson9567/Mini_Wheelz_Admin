import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mini_wheelz/core/models/product.dart';

class ProductRepository {
  ProductRepository({FirebaseFirestore? firestore, FirebaseStorage? storage})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _storage = storage ?? FirebaseStorage.instance;

  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  CollectionReference<Map<String, dynamic>> _categoryCol(String categoryId) =>
      _firestore
          .collection('categories')
          .doc(categoryId)
          .collection('products');

  Future<List<String>> uploadImages({
    required String categoryId,
    required String productName,
    required List<File> images,
  }) async {
    final List<String> urls = [];
    final safeName = productName.trim().replaceAll(
      RegExp(r"[^a-zA-Z0-9_-]"),
      '_',
    );
    for (int i = 0; i < images.length; i++) {
      final file = images[i];
      try {
        final ref = _storage
            .ref()
            .child('products')
            .child(categoryId)
            .child(
              '${DateTime.now().millisecondsSinceEpoch}_${i}_${safeName}.jpg',
            );

        final bytes = await file.readAsBytes();
        final metadata = SettableMetadata(contentType: 'image/jpeg');
        final task = await ref.putData(bytes, metadata);
        final url = await task.ref.getDownloadURL();
        urls.add(url);
      } catch (e) {
        rethrow;
      }
    }
    return urls;
  }

  Future<void> addProduct({
    required String categoryId,
    required ProductModel product,
  }) async {
    await _categoryCol(categoryId).add(product.toMap());
  }
}
