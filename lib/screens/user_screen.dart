import 'dart:convert';

import 'package:dummy_api/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    getUser();
    return Scaffold(
      body: FutureBuilder(
        future: getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.users!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data!.users![index].lastName!),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }

  Future<User> getUser() async {
    var uri = Uri.parse("https://dummyjson.com/users");
    var res = await http.get(uri);
    var data = User.fromJson(jsonDecode(res.body));
    print(data);
    return User.fromJson(jsonDecode(res.body));
  }
}
