import 'dart:convert';

import 'package:dummy_api/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getProduct();
    return Scaffold(
      body: FutureBuilder<Product>(
        future: getProduct(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            print(snapshot.data!.products![0].title!);
            return ListView.builder(
              itemCount: snapshot.data!.products!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data!.products![index].title!),
                );
              },
            );
          }

          return Container();
        },
      ),
    );
  }

  Future<Product> getProduct() async {
    var uri = Uri.parse("https://dummyjson.com/products");
    var res = await http.get(uri);
    var data = Product.fromJson(jsonDecode(res.body));
    print(data);

    return Product.fromJson(jsonDecode(res.body));
  }
}
