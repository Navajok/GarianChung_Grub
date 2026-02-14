import 'package:flutter/material.dart';
import 'package:mad_project_test/profile/profile.dart';
import 'orders.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = Profile.currentUser;
    int totalqty = 0;

    final userOrders = OrderRecords.allOrders
        .where((order) => order.user == currentUser)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('My Orders'),
            Text(
              Profile.currentUser!.name,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      body: userOrders.isEmpty
          ? const Center(
              child: Text("No orders yet",
                  style: TextStyle(fontSize: 16, color: Colors.grey)))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: userOrders.length,
              itemBuilder: (context, index) {
                final order = userOrders[index];

                // Count quantities per item
                final Map<String, Map<String, dynamic>> itemSummary = {};
                for (var item in order.items) {
                  if (!itemSummary.containsKey(item.itemName)) {
                    itemSummary[item.itemName] = {
                      'quantity': 1,
                      'price': item.price
                    };
                  } else {
                    itemSummary[item.itemName]!['quantity'] += 1;
                  }
                }

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${order.outletName} - ${order.timestamp.toLocal()}'
                              .split('.')[0],
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                        
                        const Divider(thickness: 1.5, height: 12),
                        ...itemSummary.entries.map((e) {
                          final qty = e.value['quantity'];
                          final price = e.value['price'];
                          for( int i = 0; i< qty; i++){
                            totalqty++;
                          }
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(e.key, style: const TextStyle(fontSize: 16)),
                                Text(
                                  '$qty x \$${price.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          );
                        }),

                        const Divider(thickness: 1.5, height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text('Total Items: ', 
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text('$totalqty',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),

                            const SizedBox(width: 12),

                            const Text('Total: ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text('\$${order.total.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),

                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
