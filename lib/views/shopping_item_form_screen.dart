import 'package:flutter/material.dart';
import 'package:shopping_list_app/models/shopping_item.dart';

class ShoppingItemFormScreen extends StatefulWidget {
  final ShoppingItem? shoppingItem;
  final String listId;

  const ShoppingItemFormScreen({Key? key, this.shoppingItem, required this.listId}) : super(key: key);

  @override
  State<ShoppingItemFormScreen> createState() => _ShoppingItemFormScreenState();
}

class _ShoppingItemFormScreenState extends State<ShoppingItemFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _quantity;

  @override
  void initState() {
    super.initState();
    _name = widget.shoppingItem?.name ?? '';
    _quantity = widget.shoppingItem?.quantity ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.shoppingItem == null ? 'Novo Item' : 'Editar Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(
                  labelText: 'Nome do Item',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do item.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: _quantity,
                decoration: const InputDecoration(
                  labelText: 'Quantidade (ex: 2, 1 pacote)',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  _quantity = value!;
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final newShoppingItem = ShoppingItem(
                      id: widget.shoppingItem?.id,
                      name: _name,
                      quantity: _quantity,
                      isPurchased: widget.shoppingItem?.isPurchased ?? false,
                      listId: widget.listId,
                    );
                    Navigator.pop(context, newShoppingItem);
                  }
                },
                child: Text(widget.shoppingItem == null ? 'Adicionar Item' : 'Salvar Alterações'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


