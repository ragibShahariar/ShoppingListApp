import 'package:flutter/material.dart';
import 'package:myapp/model/shoping_item_model.dart';

class ShoppingItemWidget extends StatelessWidget {
  const ShoppingItemWidget({super.key, required this.item});

  final ShopingItemModel item;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5),
      elevation: 5,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            width: 65,
            height: 65,
            color: item.itemColor,
          ),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.itemName, style: const TextStyle(fontSize: 16),),
                const SizedBox(height: 4),
                Text('৳ ${item.itemPrice.toString()}'),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(formatter.format(item.date)),
                const SizedBox(height: 4),
                Text('Qty: ${item.itemQuantity.toString()}'),
              ],
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
