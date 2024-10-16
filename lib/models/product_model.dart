class Product {
  final String productName;
  final double price;
  final int quantity;
  final String customerName;
  final String customerPhone;
  final String customerAddress;

  Product({
    required this.productName,
    required this.price,
    required this.quantity,
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
  });

  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'price': price,
      'quantity': quantity,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'customerAddress': customerAddress,
    };
  }
}
