import 'package:flutter/material.dart';
import 'package:myapp/widget/new_item_widget.dart';
import 'package:myapp/widget/shopping_item_widget.dart';
import 'package:myapp/model/shoping_item_model.dart';

class GroceryListScreen extends StatefulWidget {
  const GroceryListScreen({super.key});

  @override
  State<GroceryListScreen> createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  final List<ShopingItemModel> items = [];

  @override
  Widget build(BuildContext context) {
    Widget screenContent;
    if (items.isEmpty) {
      screenContent = const Center(
        child: Text('No items yet homie try add some...'),
      );
    } else {
      screenContent = ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(items[index].itemID),
            onDismissed: (direction) {
              setState(() {
                final item = items[index];
                items.remove(item);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${item.itemName} has been deleted'),
                    action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          setState(() {
                            items.insert(index, item);
                          });
                        }),
                  ),
                );
              });
            },
            child: ShoppingItemWidget(
              item: items[index],
            ),
          );
        },
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: () async {
              final shoppingItem =
                  await Navigator.of(context).push<ShopingItemModel>(
                MaterialPageRoute(
                  builder: (ctx) => const Newitem(),
                ),
              );
              if (shoppingItem != null) {
                setState(() {
                  items.add(shoppingItem);
                });
              } else {
                return;
              }
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(padding: const EdgeInsets.all(10), child: screenContent),
    );
  }
}
