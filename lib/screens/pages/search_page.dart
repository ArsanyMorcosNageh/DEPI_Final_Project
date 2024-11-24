import 'package:ecommerce_app/screens/product_details.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  final List<dynamic> products; // Accept products as a parameter

  SearchPage({required this.products});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<dynamic> _filteredProducts = [];
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _filteredProducts = widget.products; // Initialize with all products
  }

  void _filterProducts(String query) {
    setState(() {
      _searchText = query;
      if (query.isEmpty) {
        _filteredProducts = widget.products;
      } else {
        _filteredProducts = widget.products
            .where((product) =>
                product['title'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Products')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterProducts,
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: _filteredProducts.isEmpty
                ? const Center(child: Text('No products found'))
                : ListView.builder(
                    itemCount: _filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = _filteredProducts[index];
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetails(product: product)));
                        },
                        leading: Image.network(
                          product['image'],
                          height: 50,
                          width: 50,
                        ),
                        title: Text(product['title']),
                        subtitle: Text('Price: \$${product['price']}'),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
