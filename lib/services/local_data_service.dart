import "package:shopping_list_app/models/shopping_list.dart";
import "package:shopping_list_app/models/shopping_item.dart";

class LocalDataService {
  final List<ShoppingList> _shoppingLists = [];
  final List<ShoppingItem> _shoppingItems = [];

  List<ShoppingList> getShoppingLists() {
    return List.from(_shoppingLists);
  }

  void addShoppingList(ShoppingList list) {
    _shoppingLists.add(list);
  }

  void updateShoppingList(ShoppingList updatedList) {
    final index = _shoppingLists.indexWhere((list) => list.id == updatedList.id);
    if (index != -1) {
      _shoppingLists[index] = updatedList;
    }
  }

  void deleteShoppingList(String listId) {
    _shoppingLists.removeWhere((list) => list.id == listId);
    _shoppingItems.removeWhere((item) => item.listId == listId);
  }

  List<ShoppingItem> getShoppingItemsForList(String listId) {
    return _shoppingItems.where((item) => item.listId == listId).toList();
  }

  void addShoppingItem(ShoppingItem item) {
    _shoppingItems.add(item);
  }

  void updateShoppingItem(ShoppingItem updatedItem) {
    final index = _shoppingItems.indexWhere((item) => item.id == updatedItem.id);
    if (index != -1) {
      _shoppingItems[index] = updatedItem;
    }
  }

  void deleteShoppingItem(String itemId) {
    _shoppingItems.removeWhere((item) => item.id == itemId);
  }

  void clearPurchasedItems(String listId) {
    _shoppingItems.removeWhere((item) => item.listId == listId && item.isPurchased);
  }
}


