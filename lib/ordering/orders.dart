import 'package:mad_project_test/profile/profile.dart';

/// Represents a single item in an order
class OrderItem {
  final String itemName;
  final double price;

  OrderItem({
    required this.itemName,
    required this.price,
  });
}

/// Represents a full order from a user
class Order {
  final AppUser user;
  final String outletName;
  final List<OrderItem> items;
  final DateTime timestamp;

  Order({
    required this.user,
    required this.outletName,
    required this.items,
    required this.timestamp,
  });

  double get total =>
      items.fold(0, (sum, item) => sum + item.price); // total price
}

/// Manages all orders in the app
class OrderRecords {
  static final List<Order> _orders = [];

  static List<Order> get allOrders => _orders;

  static void addOrder(Order order) {
    _orders.add(order);
  }
}
