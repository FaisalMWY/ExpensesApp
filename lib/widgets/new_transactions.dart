import 'package:flutter/material.dart';

class NewTransactions extends StatefulWidget {
  // submitTransition is created recieve the function that adds a transaction
  // to the TransactionList
  final Function submitTransaction;

  NewTransactions(this.submitTransaction);

  @override
  State<NewTransactions> createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  // controllers are made to listen and give... in our case here we have two
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void addTransaction() {
    final titleEntered = titleController.text;
    final amountEntered = double.parse(amountController.text);
    if (titleEntered.isEmpty || amountEntered <= 0) {
      return;
    }
    widget.submitTransaction(
      titleController.text,
      double.parse(amountController.text),
    );
    Navigator.of(context).pop;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      // Container is used to creat a space between the contents of the
      // Card since nither Card nor column have the ability to do so
      child: Container(
        padding: EdgeInsets.all(10),
        // column contains the contents of the Card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              // decoratoin in this case decorates the TextField it self
              // while we only see labelText but the input decoration
              // class contains way more decoration attributes.
              decoration: InputDecoration(labelText: "Title"),
              // the first listener we have here is the titleController which
              // saves the value of the Textfield
              controller: titleController,
              onSubmitted: (_) => addTransaction(),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              // the second listener we have here is the amountController which
              // saves the value of the Textfield
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => addTransaction(),
            ),
            FlatButton(
              // onPressed determines what happens when the button is
              onPressed: addTransaction,
              child: Text("Add Transactoin"),
            ),
          ],
        ),
      ),
    );
  }
}
