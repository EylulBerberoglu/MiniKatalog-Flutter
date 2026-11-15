
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'cart_page.dart';

import 'models/product.dart';
import 'product_detail_page.dart';

void main() {
  runApp(const MiniKatalogApp());
}

class MiniKatalogApp extends StatelessWidget {
  const MiniKatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mini Katalog',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> products = [];
  bool isLoading = true;
  String? errorMessage;
  String searchQuery = '';

  List<Product> get filteredProducts {
    return products.where((product) {
      return product.name
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      final String response =
          await rootBundle.loadString('assets/data/products.json');

      final List<dynamic> data = jsonDecode(response);

      if (!mounted) return;

      setState(() {
        products = data
            .map(
              (item) => Product.fromJson(
                item as Map<String, dynamic>,
              ),
            )
            .toList();

        isLoading = false;
        errorMessage = null;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        errorMessage = 'Ürünler yüklenemedi: $e';
        isLoading = false;
      });
    }
  }

  IconData getProductIcon(String iconName) {
    switch (iconName) {
      case 'headphones':
        return Icons.headphones;
      case 'watch':
        return Icons.watch;
      case 'laptop':
        return Icons.laptop;
      case 'smartphone':
        return Icons.smartphone;
      case 'camera':
        return Icons.camera_alt;
      case 'speaker':
        return Icons.speaker;
      default:
        return Icons.shopping_bag;
    }
  }


String getProductImage(String icon) {
  switch (icon) {
    case 'headphones':
      return 'assets/images/headphones.png';
    case 'watch':
      return 'assets/images/watch.png';
    case 'laptop':
      return 'assets/images/laptop.png';
    case 'smartphone':
      return 'assets/images/phone.png';
    case 'camera':
      return 'assets/images/camera.png';
    case 'speaker':
      return 'assets/images/speaker.png';
    default:
      return 'assets/images/headphones.png';
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
appBar: AppBar(
  title: const Text('Mini Katalog'),
  backgroundColor: Colors.indigo,
  foregroundColor: Colors.white,
  actions: [
    IconButton(
      icon: const Icon(Icons.shopping_cart),
      tooltip: 'Sepetim',
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CartPage(),
          ),
        );
      },
    ),
  ],
),

      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : errorMessage != null
              ? Center(
                  child: Text(errorMessage!),
                )
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Ürün ara...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: filteredProducts.isEmpty
                            ? const Center(
                                child: Text(
                                  'Aradığınız ürün bulunamadı.',
                                ),
                              )
                            : GridView.builder(
                                itemCount: filteredProducts.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  childAspectRatio: 0.85,
                                ),
                                itemBuilder: (context, index) {
                                  final product =
                                      filteredProducts[index];

                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailPage(
                                            
product: {
  'id': product.id,
  'name': product.name,
  'price': product.price,
  'description': product.description,
  'iconName': product.icon,
  'icon': getProductIcon(product.icon),
  'image': getProductImage(product.icon),
},

                                          ),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      elevation: 3,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          

Image.asset(
  getProductImage(product.icon),
  width: 100,
  height: 100,
  fit: BoxFit.contain,
),


                                          const SizedBox(height: 16),
                                          Text(
                                            product.name,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            '${product.price.toStringAsFixed(0)} TL',
                                            style: const TextStyle(
                                              color: Colors.indigo,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
