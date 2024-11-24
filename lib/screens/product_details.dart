import 'package:ecommerce_app/screens/widgets/app_constants.dart';
import 'package:ecommerce_app/screens/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetails extends StatefulWidget {
  final Map<String, dynamic> product;
  const ProductDetails({super.key, required this.product});
  @override
  State<StatefulWidget> createState() => ProductDetailsState();
}

class ProductDetailsState extends State<ProductDetails> {
  int quantity = 1;

  Future<void> addToCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('product_id_${widget.product["id"]}', quantity);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('${widget.product["title"]} added to cart'),
      duration: const Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.product["title"],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.product["image"],
                width: double.infinity,
                height: 300,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "\$${widget.product["price"].toStringAsFixed(2)}",
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.kPrimaryColor),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    "${widget.product["rating"]["rate"].toString()}",
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    "${widget.product["rating"]["count"].toString()} reviews",
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                widget.product["description"],
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          quantity--;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          backgroundColor: AppConstants.kPrimaryColor),
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      )),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    quantity.toString(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          backgroundColor: AppConstants.kPrimaryColor),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      )),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      addToCart();
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        backgroundColor: AppConstants.kPrimaryColor),
                    child: const Text(
                      "Add to Cart",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
