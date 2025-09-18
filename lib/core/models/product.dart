import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final String description;
  final String categoryId;
  final List<String> imageUrls;
  final DateTime createdAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.description,
    required this.categoryId,
    required this.imageUrls,
    required this.createdAt,
  });

  factory ProductModel.fromDocument(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? {};
    return ProductModel(
      id: doc.id,
      name: data['name'] as String? ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0,
      quantity: (data['quantity'] as num?)?.toInt() ?? 0,
      description: data['description'] as String? ?? '',
      categoryId: data['categoryId'] as String? ?? '',
      imageUrls: (data['imageUrls'] as List<dynamic>? ?? [])
          .map((e) => e as String)
          .toList(),
      createdAt:
          (data['createdAt'] as Timestamp?)?.toDate() ??
          DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'quantity': quantity,
      'description': description,
      'categoryId': categoryId,
      'imageUrls': imageUrls,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
