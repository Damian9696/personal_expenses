import 'package:flutter/material.dart';

import 'package:personal_expenses/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
        id: "0",
        title: "New shoes",
        amount: 23.43,
        date: DateTime.now()),
    Transaction(
        id: "1",
        title: "Car",
        amount: 150.00,
        date: DateTime.now())
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.blue,
              child: Text("Chart"),
            ),
          ),
          Column(
            children: transactions.map((transaction) {
              return Card(
                  color: Colors.red,
                  child: Text(transaction.title));
            }).toList(),
          )
        ],
      ),
    );
  }
}
