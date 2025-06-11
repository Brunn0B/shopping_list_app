import 'package:flutter/material.dart';
import 'package:shopping_list_app/models/shopping_list.dart';
import 'package:shopping_list_app/services/local_data_service.dart';
import 'package:shopping_list_app/views/shopping_list_form_screen.dart';
import 'package:shopping_list_app/views/shopping_list_detail_screen.dart';

class ShoppingListScreen extends StatefulWidget {
  final LocalDataService dataService;

  const ShoppingListScreen({Key? key, required this.dataService}) : super(key: key);

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  List<ShoppingList> _shoppingLists = [];

  @override
  void initState() {
    super.initState();
    _loadShoppingLists();
  }

  void _loadShoppingLists() {
    setState(() {
      _shoppingLists = widget.dataService.getShoppingLists();
    });
  }

  void _addShoppingList() async {
    final result = await Navigator.push<ShoppingList>(
      context,
      MaterialPageRoute(
        builder: (context) => const ShoppingListFormScreen(),
      ),
    );

    if (result != null) {
      widget.dataService.addShoppingList(result);
      _loadShoppingLists();
    }
  }

  void _editShoppingList(ShoppingList list) async {
    final result = await Navigator.push<ShoppingList>(
      context,
      MaterialPageRoute(
        builder: (context) => ShoppingListFormScreen(shoppingList: list),
      ),
    );

    if (result != null) {
      widget.dataService.updateShoppingList(result);
      _loadShoppingLists();
    }
  }

  void _deleteShoppingList(String listId) {
    setState(() {
      widget.dataService.deleteShoppingList(listId);
      _loadShoppingLists();
    });
  }

  void _viewShoppingListDetails(ShoppingList list) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShoppingListDetailScreen(
          shoppingList: list,
          dataService: widget.dataService,
        ),
      ),
    ).then((_) => _loadShoppingLists());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Listas de Compras'),
      ),
      body: _shoppingLists.isEmpty
          ? const Center(
              child: Text('Nenhuma lista de compras criada ainda.'),
            )
          : ListView.builder(
              itemCount: _shoppingLists.length,
              itemBuilder: (context, index) {
                final list = _shoppingLists[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(list.name),
                    subtitle: Text(list.category),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _editShoppingList(list),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteShoppingList(list.id),
                        ),
                      ],
                    ),
                    onTap: () {
                      _viewShoppingListDetails(list);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addShoppingList,
        child: const Icon(Icons.add),
      ),
    );
  }
}


