import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              // onChanged: (value) => titleInput = value,
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              // onChanged: (value) => amountInput = value,
              controller: amountController,
            ),
            TextButton(
              onPressed: () {},
              child: Text("Add transaction"),
              style: TextButton.styleFrom(primary: Colors.blue),
            )
          ],
        ),
      ),
    );
  }
}
