import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> userTransaction;

  TransactionList(this.userTransaction);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: userTransaction.map((transaction) {
      return Card(
          child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.blueAccent)),
            padding: EdgeInsets.all(10),
            child: Text(
              "\$${transaction.amount}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.blueAccent),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaction.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                DateFormat('dd-MM-yyyy').format(transaction.date),
                style: TextStyle(color: Colors.grey),
              ),
            ],
          )
        ],
      ));
    }).toList());
  }
}
