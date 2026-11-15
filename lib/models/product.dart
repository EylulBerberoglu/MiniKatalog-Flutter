
class Product {
  final int id;
  final String name;
  final double price;
  final String description;
  final String icon;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.icon,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      icon: json['icon'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'icon': icon,
    };
  }
}
