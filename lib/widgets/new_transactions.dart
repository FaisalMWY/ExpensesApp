import 'package:flutter/material.dart';

class NewTransactions extends StatelessWidget {
  // submitTransition is created recieve the function that adds a transaction
  // to the TransactionList
  final Function submitTransaction;
  // controllers are made to listen and give... in our case here we have two
  // listeners the title listener titleController, and the AmountController
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  // here is where the function that adds a new transaction is invoked
  NewTransactions(this.submitTransaction);

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
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              // the second listener we have here is the amountController which
              // saves the value of the Textfield
              controller: amountController,
            ),
            FlatButton(
              // onPressed determines what happens when the button is
              onPressed: () {
                // this button is responsible of adding the new transactino to
                // the screen.
                submitTransaction(
                  titleController.text,
                  double.parse(amountController.text),
                );
              },
              child: Text("Add Transactoin"),
            ),
          ],
        ),
      ),
    );
  }
}
