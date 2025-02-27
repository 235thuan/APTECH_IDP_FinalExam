// Model lớp Order
class Order {
  final String id; // ID tự động tạo
  final String item;
  final String itemName;
  final double price;
  final String currency;
  final int quantity;

  Order({
    required this.id,
    required this.item,
    required this.itemName,
    required this.price,
    required this.currency,
    required this.quantity,
  });

  // Chuyển đổi từ JSON sang Object
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
      item: json['Item'] ?? '',
      itemName: json['ItemName'] ?? '',
      price: (json['Price'] ?? 0).toDouble(),
      currency: json['Currency'] ?? 'USD',
      quantity: json['Quantity'] ?? 0,
    );
  }

  // Chuyển đổi từ Object sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Item': item,
      'ItemName': itemName,
      'Price': price,
      'Currency': currency,
      'Quantity': quantity,
    };
  }
} 