import 'package:card_swiper/card_swiper.dart';
import 'package:ecommerce_app/screens/product_details.dart';
import 'package:ecommerce_app/screens/widgets/app_constants.dart';
import 'package:ecommerce_app/screens/widgets/custom_app_name.dart';
import 'package:ecommerce_app/screens/widgets/product_card.dart';
import 'package:ecommerce_app/screens/widgets/skeleton_product_card.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatefulWidget {
  static String id = 'homePage';
  final List<dynamic> products;
  const HomePage({super.key, required this.products});
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final List<dynamic> categories = [
    "All",
    "men's clothing",
    "women's clothing",
    "electronics",
    "jewelery"
  ];
  String selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const CustomAppName(),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: size.height * 0.22,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Swiper(
                autoplay: true,
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    AppConstants.banners[index],
                    fit: BoxFit.fill,
                  );
                },
                itemCount: AppConstants.banners.length,
                pagination: const SwiperPagination(
                  builder: DotSwiperPaginationBuilder(activeColor: Colors.blue),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Skeletonizer(
              enabled: widget.products.isEmpty,
              child: SizedBox(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = categories[index];
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                              color: selectedCategory == categories[index]
                                  ? AppConstants.kPrimaryColor
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: AppConstants.kPrimaryColor)),
                          child: Text(
                            categories[index],
                            style: TextStyle(
                                color: selectedCategory == categories[index]
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }),
              )),
          SizedBox(
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: widget.products.isEmpty
                      ? Skeletonizer(
                          enabled: true,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return const SkeletonProductCard();
                              }))
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.products.length,
                          itemBuilder: (context, index) {
                            final product = widget.products[index];
                            if (selectedCategory == "All" ||
                                selectedCategory == product["category"]) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductDetails(
                                              product: product)));
                                },
                                child: ProductCard(
                                  product: product,
                                ),
                              );
                            } else {
                              return Container();
                            }
                          })))
        ],
      ),
    );
  }
}
