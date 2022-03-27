import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Countries extends StatefulWidget {
  const Countries({Key? key}) : super(key: key);

  @override
  State<Countries> createState() => _CountriesState();
}

class _CountriesState extends State<Countries> {
  Map<String, dynamic> myList = {};

  Map<String, dynamic> countries(String body) {
    final parsed = json.decode(body);

    return parsed;
  }

  Future<List<String>> getCountries() async {
    var response = await http.get(Uri.parse("http://country.io/names.json"));
    if (response.statusCode == 200) {
      setState(() {
        myList = countries(response.body);
      });
    } else {
      setState(() {});
    }
    return [];
  }

  @override
  void initState() {
    super.initState();
    getCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: myList.length,
          itemBuilder: (context, index) {
            List<String> keys = myList.keys.toList();
            keys.sort();
            return ListTile(
              title: Text(myList[keys[index]]),
            );
          },
        ),
      ),
    );
  }
}
