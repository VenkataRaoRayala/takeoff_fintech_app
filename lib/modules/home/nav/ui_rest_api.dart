import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:takeoff_fintech_app/model_classes/user_model.dart';

class ShowImagesUi extends StatefulWidget {
  const ShowImagesUi({Key? key}) : super(key: key);

  @override
  _ShowImagesUiState createState() => _ShowImagesUiState();
}

class _ShowImagesUiState extends State<ShowImagesUi> {
  bool loading = false;
  List<User> users = [];
  Future<void> getResponse() async {
    setState(() {
      loading = true;
    });
    final response = await http.get(
      Uri.parse('https://dummyapi.io/data/v1/user?limit=10'),
      // Send authorization headers to the backend.
      headers: {'app-id': "6142039cea175be4e530e2e5"},
    );
    if (response.statusCode == 200) {
      setState(() {
        loading = false;
      });
      final data = json.decode(response.body);
      int i = 0;
      for (var item in data['data']) {
        users.insert(i, User.fromJson(item));
        i++;
      }
    } else {
      throw Exception('Failed to load album');
    }
  }

  late double width;
  late double height;

  @override
  void initState() {
    getResponse();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(
        child: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                    width: width,
                    height: height,
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: (width / height),
                      children: List.generate(users.length, (index) {
                        return Card(
                          child: Column(
                            children: [
                              Container(
                                  width: 200,
                                  height: 200,
                                  child: Image.network(
                                      users[index].picture.toString())),
                              Text(users[index].title.toString()),
                              Text(users[index].firstName.toString()),
                              Text(users[index].lastName.toString()),
                            ],
                          ),
                        );
                      }),
                    ))));
  }
}
