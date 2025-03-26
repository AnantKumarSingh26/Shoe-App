import 'package:flutter/material.dart';
import 'package:shop_app_flutter/global_variable.dart';
import 'package:shop_app_flutter/product_card.dart';
import 'package:shop_app_flutter/product_details_page.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const ['All', 'Adidas', 'Bata', 'Nike'];
  late String selectedFilter = filters[0];
  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromRGBO(225, 225, 225, 1)),
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(50),
          // right: Radius.circular(50),
        ));
    return Column(
      children: [
        //header
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Shoes \nCollection',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: border,
                  enabledBorder: border,
                  focusedBorder: border,
                ),
              ),
            ),
          ],
        ),

        SizedBox(
          height: 120,
          child: ListView.builder(
            itemCount: filters.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final filter = filters[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedFilter = filter;
                    });
                  },
                  child: Chip(
                      backgroundColor: selectedFilter == filter
                          ? Theme.of(context).colorScheme.primary
                          : const Color.fromRGBO(245, 247, 249, 1),
                      side: BorderSide(
                        color: const Color.fromRGBO(245, 247, 247, 1),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      label: Text(filter),
                      labelStyle:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
              );
            },
          ),
        ),
        //3rd Section
        Expanded(
          child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return ProductDetailsPage(product: product);
                  }));
                },
                child: ProductCard(
                  title: product['title'] as String,
                  price: product['price'] as double,
                  image: product['imageUrl'] as String,
                  backgroundColor: index.isEven
                      ? const Color.fromRGBO(216, 240, 253, 1)
                      : const Color.fromRGBO(245, 247, 249, 1),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
