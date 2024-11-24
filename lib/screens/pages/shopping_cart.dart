import 'package:ecommerce_app/screens/widgets/app_constants.dart';
import 'package:ecommerce_app/screens/widgets/custom_app_bar.dart';
import 'package:ecommerce_app/screens/widgets/custom_checkout.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingCart extends StatefulWidget {
  final List products;
  const ShoppingCart({super.key, required this.products});
  @override
  State<StatefulWidget> createState() => ShoppingCartState();
}

class ShoppingCartState extends State<ShoppingCart> {
  List<Map<String, dynamic>> _cartItems = [];

  @override
  void initState() {
    super.initState();
    _getCartItems();
  }

  Future<void> _getCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    //product_id_78
    _cartItems = keys.where((key) => key.startsWith('product_id')).map((e) {
      final productId = e.split('_')[2];
      final quantity = prefs.getInt(e);
      final product = widget.products
          .firstWhere((element) => element['id'].toString() == productId);

      return {
        'id': productId,
        'title': product['title'],
        'image': product['image'],
        'price': product['price'],
        'quantity': quantity
      };
    }).toList();
    setState(() {});
  }

  Future<void> updateQuantity(String productId, int newQuantity) async {
    if (newQuantity < 1) {
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('product_id_$productId', newQuantity);
    _getCartItems();
  }

  Future<void> deleteQuantity(String productId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('product_id_$productId');
    _getCartItems();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool cartHasItems = _cartItems.isNotEmpty;
    return Scaffold(
      bottomSheet: Visibility(
        visible: cartHasItems,
        child: const CustomCheckOut(),
      ),
      appBar: const CustomAppBar(title: "Shopping Cart"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: cartHasItems
            ? ListView.separated(
                itemBuilder: (context, index) {
                  final item = _cartItems[index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            item['image'],
                            height: 100,
                            width: 100,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title'],
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    item['price'].toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppConstants.kPrimaryColor),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            updateQuantity(item['id'],
                                                item['quantity'] - 1);
                                          },
                                          icon: const Icon(Icons.remove)),
                                      Text('Quantity: ${item['quantity']}'),
                                      FittedBox(
                                        child: IconButton(
                                            onPressed: () {
                                              updateQuantity(item['id'],
                                                  item['quantity'] + 1);
                                            },
                                            icon: const Icon(Icons.add)),
                                      ),
                                      const Spacer(),
                                      FittedBox(
                                        child: IconButton(
                                            onPressed: () {
                                              deleteQuantity(item['id']);
                                            },
                                            icon: const Icon(Icons.delete)),
                                      )
                                    ],
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                      height: 16,
                    ),
                itemCount: _cartItems.length)
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/images/abandoned-cart.png',
                      height: size.height * 0.25,
                    ),
                    const Text(
                      textAlign: TextAlign.center,
                      'Opps You do not have products in your Card , fill it now',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
