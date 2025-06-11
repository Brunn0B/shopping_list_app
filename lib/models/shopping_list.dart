import 'package:uuid/uuid.dart';

class ShoppingList {
  String id;
  String name;
  String category;
  DateTime createdAt;

  ShoppingList({
    String? id,
    required this.name,
    required this.category,
    DateTime? createdAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ShoppingList.fromMap(Map<String, dynamic> map) {
    return ShoppingList(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}


