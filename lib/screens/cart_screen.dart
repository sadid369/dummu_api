import 'dart:convert';

import 'package:dummy_api/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    getCart();
    return Scaffold(
      body: FutureBuilder<Cart>(
        future: getCart(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.carts!.length,
              itemBuilder: (context, index) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.carts![index].products!.length,
                  itemBuilder: (context, pIndex) {
                    return ListTile(
                      title: Text(snapshot
                          .data!.carts![index].products![pIndex].title!),
                    );
                  },
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }

  Future<Cart> getCart() async {
    var uri = Uri.parse("https://dummyjson.com/carts");
    var res = await http.get(uri);
    var data = Cart.fromJson(jsonDecode(res.body));
    print(data);
    return Cart.fromJson(jsonDecode(res.body));
  }
}
