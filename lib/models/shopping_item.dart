import 'package:uuid/uuid.dart';

class ShoppingItem {
  String id;
  String name;
  String quantity;
  bool isPurchased;
  String listId;

  ShoppingItem({
    String? id,
    required this.name,
    required this.quantity,
    this.isPurchased = false,
    required this.listId,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'isPurchased': isPurchased,
      'listId': listId,
    };
  }

  factory ShoppingItem.fromMap(Map<String, dynamic> map) {
    return ShoppingItem(
      id: map['id'],
      name: map['name'],
      quantity: map['quantity'],
      isPurchased: map['isPurchased'] ?? false,
      listId: map['listId'],
    );
  }
}


