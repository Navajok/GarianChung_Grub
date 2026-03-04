import 'package:flutter/material.dart';
import 'orders.dart';
import 'package:mad_project_test/profile/profile.dart';
import 'package:mad_project_test/data/menu_items.dart';
import 'package:mad_project_test/data/menu_item_images.dart';
import 'package:mad_project_test/data/menu_foodoutlets.dart';
import 'package:mad_project_test/reviews/reviews.dart';
import 'dart:async';

class OrderingPage extends StatefulWidget {
  final FoodOutlet foodOutlet;

  const OrderingPage({super.key, required this.foodOutlet});

  @override
  State<OrderingPage> createState() => _OrderingPageState();
}

class _OrderingPageState extends State<OrderingPage> {
  final Map<String, int> selectedItems = {};
  Timer? timer;

  void addItem(String item) {
    setState(() {
      selectedItems[item] = (selectedItems[item] ?? 0) + 1;
    });
  }

  void removeItem(String item) {
    setState(() {
      if (selectedItems.containsKey(item)) {
        selectedItems[item] = selectedItems[item]! - 1;
        if (selectedItems[item]! <= 0) {
          selectedItems.remove(item);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final menuItems = outletMenus[widget.foodOutlet.name]!;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.foodOutlet.name),
            Text(
              Profile.currentUser!.name,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Outlet image
            Container(
              height: 180,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.foodOutlet.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Outlet description
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.foodOutlet.description,
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 18),
                      const SizedBox(width: 4),
                      Text(widget.foodOutlet.rating,
                          style: const TextStyle(fontSize: 14)),
                      const SizedBox(width: 12),
                      const Icon(Icons.timer, size: 18, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(widget.foodOutlet.deliveryTime),
                    ],
                  ),
                ],
              ),
            ),

            // Menu header
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text('Menu',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),

            // Menu grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.7,
              ),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final itemName = menuItems.keys.elementAt(index);
                final price = menuItems[itemName]!;
                final quantity = selectedItems[itemName] ?? 0;
                final itemImage = menuImage[widget.foodOutlet.name]![itemName]!;

                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 7,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                image: DecorationImage(
                                  image: AssetImage(itemImage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            if (quantity > 0)
                              Positioned(
                                top: 4,
                                right: 4,
                                child: CircleAvatar(
                                  radius: 14,
                                  backgroundColor: Colors.green,
                                  child: Text('$quantity',
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.white)),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(itemName,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('\$${price.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.green)),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //remove item
                            GestureDetector(
                              onTap: () {
                                if (quantity > 0) {
                                  removeItem(itemName);
                                }
                              },
                              onLongPressStart: (_) {
                                // start rapid removal
                                timer = Timer.periodic(
                                    const Duration(milliseconds: 150), (_) {
                                  if (quantity > 0) removeItem(itemName);
                                });
                              },
                              onLongPressEnd: (_) {
                                // stop rapid removal
                                timer?.cancel();
                              },
                              child: Icon(
                                Icons.remove_circle_outline,
                                size: 28,
                                color: quantity > 0
                                    ? Colors.red
                                    : Colors.grey, // visually disabled
                              ),
                            ),


                            if (quantity > 0) 
                            Text(quantity.toString(), style: const TextStyle(fontSize: 16),),


                            //add item
                            GestureDetector(
                              onTap: () {
                                addItem(itemName); // normal tap adds 1
                              },
                              onLongPressStart: (_) {
                                // start rapid add
                                timer = Timer.periodic(
                                    const Duration(milliseconds: 150), (_) {
                                  addItem(itemName);
                                });
                              },
                              onLongPressEnd: (_) {
                                // stop rapid add
                                timer?.cancel();
                              },
                              child: const Icon(
                                Icons.add_circle_outline,
                                size: 28,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            // place order button
            Padding(
              padding: const EdgeInsets.all(6),
              child: ElevatedButton(
                onPressed: selectedItems.isNotEmpty
                    ? () {
                        final user = Profile.currentUser!;
                        final List<OrderItem> items = [];
                        double totalPrice = 0;

                        for (var x in selectedItems.entries) {
                          final itemName = x.key;
                          final quantity = x.value;
                          final price = menuItems[itemName]!;

                          for (int i = 0; i < quantity; i++) {
                            items.add(
                                OrderItem(itemName: itemName, price: price));
                          }

                          totalPrice += price * quantity;
                        }

                        //creates new order and adds it
                        OrderRecords.addOrder(Order(
                          user: user,
                          outletName: widget.foodOutlet.name,
                          items: items,
                          timestamp: DateTime.now(),
                        ));

                        String orderSummary = "";
                        for (var entry in selectedItems.entries) {
                          orderSummary += "${entry.key} x${entry.value}\n";
                        }
                        orderSummary +=
                            "\nTotal: \$${totalPrice.toStringAsFixed(2)}";

                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text("Order Placed!"),
                            content: Text(orderSummary),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("OK"))
                            ],
                          ),
                        );
                        setState(() => selectedItems.clear());
                      }
                    : null,
                child: const Text('Place Order'),
              ),
            ),
            // Reviews section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: ReviewsSection(outletName: widget.foodOutlet.name),
            ),
          ],
        ),
      ),
    );
  }
}
