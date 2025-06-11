import 'package:flutter/material.dart';
import 'package:shopping_list_app/models/shopping_list.dart';

class ShoppingListFormScreen extends StatefulWidget {
  final ShoppingList? shoppingList;

  const ShoppingListFormScreen({Key? key, this.shoppingList}) : super(key: key);

  @override
  State<ShoppingListFormScreen> createState() => _ShoppingListFormScreenState();
}

class _ShoppingListFormScreenState extends State<ShoppingListFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _category;

  @override
  void initState() {
    super.initState();
    _name = widget.shoppingList?.name ?? '';
    _category = widget.shoppingList?.category ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.shoppingList == null ? 'Nova Lista de Compras' : 'Editar Lista de Compras'),
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
                  labelText: 'Nome da Lista',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um nome para a lista.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: _category,
                decoration: const InputDecoration(
                  labelText: 'Categoria (ex: Supermercado, Farmácia)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma categoria.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _category = value!;
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final newShoppingList = ShoppingList(
                      id: widget.shoppingList?.id,
                      name: _name,
                      category: _category,
                      createdAt: widget.shoppingList?.createdAt,
                    );
                    Navigator.pop(context, newShoppingList);
                  }
                },
                child: Text(widget.shoppingList == null ? 'Criar Lista' : 'Salvar Alterações'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


