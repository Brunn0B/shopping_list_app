import 'package:flutter/material.dart';
import 'package:shopping_list_app/models/shopping_list.dart';
import 'package:shopping_list_app/models/shopping_item.dart';
import 'package:shopping_list_app/services/local_data_service.dart';
import 'package:shopping_list_app/views/shopping_item_form_screen.dart';

class ShoppingListDetailScreen extends StatefulWidget {
  final ShoppingList shoppingList;
  final LocalDataService dataService;

  const ShoppingListDetailScreen({
    Key? key,
    required this.shoppingList,
    required this.dataService,
  }) : super(key: key);

  @override
  State<ShoppingListDetailScreen> createState() => _ShoppingListDetailScreenState();
}

class _ShoppingListDetailScreenState extends State<ShoppingListDetailScreen> {
  List<ShoppingItem> _shoppingItems = [];

  @override
  void initState() {
    super.initState();
    _loadShoppingItems();
  }

  void _loadShoppingItems() {
    setState(() {
      _shoppingItems = widget.dataService.getShoppingItemsForList(widget.shoppingList.id);
    });
  }

  void _addShoppingItem() async {
    final result = await Navigator.push<ShoppingItem>(
      context,
      MaterialPageRoute(
        builder: (context) => ShoppingItemFormScreen(listId: widget.shoppingList.id),
      ),
    );

    if (result != null) {
      widget.dataService.addShoppingItem(result);
      _loadShoppingItems();
    }
  }

  void _togglePurchased(ShoppingItem item) {
    setState(() {
      final updatedItem = ShoppingItem(
        id: item.id,
        name: item.name,
        quantity: item.quantity,
        isPurchased: !item.isPurchased,
        listId: item.listId,
      );
      widget.dataService.updateShoppingItem(updatedItem);
      _loadShoppingItems();
    });
  }

  void _editShoppingItem(ShoppingItem item) async {
    final result = await Navigator.push<ShoppingItem>(
      context,
      MaterialPageRoute(
        builder: (context) => ShoppingItemFormScreen(shoppingItem: item, listId: widget.shoppingList.id),
      ),
    );

    if (result != null) {
      widget.dataService.updateShoppingItem(result);
      _loadShoppingItems();
    }
  }

  void _deleteShoppingItem(String itemId) {
    setState(() {
      widget.dataService.deleteShoppingItem(itemId);
      _loadShoppingItems();
    });
  }

  void _clearPurchasedItems() {
    setState(() {
      widget.dataService.clearPurchasedItems(widget.shoppingList.id);
      _loadShoppingItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.shoppingList.name),
        actions: [
          if (_shoppingItems.any((item) => item.isPurchased))
            IconButton(
              icon: const Icon(Icons.clear_all),
              tooltip: 'Limpar itens comprados',
              onPressed: _clearPurchasedItems,
            ),
        ],
      ),
      body: _shoppingItems.isEmpty
          ? const Center(
              child: Text('Nenhum item nesta lista.'),
            )
          : ListView.builder(
              itemCount: _shoppingItems.length,
              itemBuilder: (context, index) {
                final item = _shoppingItems[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: ListTile(
                    leading: Checkbox(
                      value: item.isPurchased,
                      onChanged: (bool? value) {
                        _togglePurchased(item);
                      },
                    ),
                    title: Text(
                      item.name,
                      style: TextStyle(
                        decoration: item.isPurchased ? TextDecoration.lineThrough : null,
                        color: item.isPurchased ? Colors.grey : null,
                      ),
                    ),
                    subtitle: Text(item.quantity),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _editShoppingItem(item),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteShoppingItem(item.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addShoppingItem,
        child: const Icon(Icons.add),
      ),
    );
  }
}


