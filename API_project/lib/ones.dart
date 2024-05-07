import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Ones extends StatefulWidget {
  const Ones({super.key});

  @override
  State<Ones> createState() => _OnesState();
}

class _OnesState extends State<Ones> {
  List<dynamic> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          const url = 'https://randomuser.me/api/?results=50';
          final wry = Uri.parse(url);
          final respose = await http.get(wry);
          final bodys = respose.body;
          final jsond = jsonDecode(bodys);
          print(jsond);
          // setstate
          setState(() {
            users = jsond['results'];
          });
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent[100],
        title: Text(
          'Ones Page',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      // body
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(users[index]['name']['first']),
            subtitle: Text(users[index]['email']),
            leading: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(users[index]['picture']['large'])),
          );
        },
        itemCount: users.length,
      ),
    );
  }
}
