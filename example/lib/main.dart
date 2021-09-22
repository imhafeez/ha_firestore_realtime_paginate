import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ha_firestore_paginated_list/ha_firestore_paginated_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: HAFirestoreRealtimePaginatedView.list(
        scrollPadding: const EdgeInsets.only(bottom: 90),
        query: FirebaseFirestore.instance
            .collection("users")
            .orderBy("addedDate", descending: true),
        limit: 10,
        builder: (context, snapshot) {
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          return ListTile(
            title: Text(data['name'] ?? "no name"),
          );
        },
        emptyWidget: const Center(
          child: Text("no data found"),
        ),
      ),
    );
  }
}
