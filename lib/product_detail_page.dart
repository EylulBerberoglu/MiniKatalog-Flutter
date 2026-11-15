
import 'package:flutter/material.dart';
import 'cart.dart';
import 'models/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ürün Detayı'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 30),
            
Image.asset(
  product['image'] as String,
  width: 220,
  height: 220,
  fit: BoxFit.contain,
),

            const SizedBox(height: 40),
            Text(
              product['name'] as String,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '${product['price']} TL',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.indigo,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Ürün Açıklaması',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${product['name']} yüksek kaliteli, '
              'modern tasarıma sahip bir üründür.',
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            
ElevatedButton(
  onPressed: () {
    final selectedProduct = Product(
      id: product['id'] as int,
      name: product['name'] as String,
      price: (product['price'] as num).toDouble(),
      description: product['description'] as String,
      icon: product['iconName'] as String,
    );

    Cart.addProduct(selectedProduct);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ürün sepete eklendi!'),
        duration: Duration(seconds: 2),
      ),
    );
  },
  child: const Text('Sepete Ekle'),
),

          ],
        ),
      ),
    );
  }
}
