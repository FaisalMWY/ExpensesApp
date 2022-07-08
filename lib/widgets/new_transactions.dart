import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _addTransaction() {
    final titleEntered = _titleController.text;
    final amountEntered = double.parse(_amountController.text);
    if (titleEntered.isEmpty || amountEntered <= 0) {
      return;
    }
    widget.submitTransaction(_titleController.text,
        double.parse(_amountController.text), _selectedDate);
    Navigator.of(context).pop;
  }

  // _datePicker uses showDatePicker to show the date picker widget.
  // but first we need four arguments first we need the context of the widget
  // tree, second we need the initialDate which is now, then we have first date
  // which is the first date we can choose, in our case its the year 2000
  // finally we have our lastDate which is the last date we can pick
  // in our case its now, since we cannot predict the future for the time being ^^
  void _datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      //.then is used to do an action depending on the
      // outcome of an input of another action
      setState(() {
        //here we used set state to change the value of the text to
        // the new date
        _selectedDate = pickedDate!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        // Container is used to creat a space between the contents of the
        // Card since nither Card nor column have the ability to do so
        child: Padding(
          padding: EdgeInsets.only(
              top: 10,
              // viewInsets finds the overlapping widget (If any if not it'll
              // return 0) and adds 10 to it to avoid having an unseeable screen
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
              left: 10,
              right: 10),
          // column contains the contents of the Card
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                // decoratoin in this case decorates the TextField it self
                // while we only see labelText but the input decoration
                // class contains way more decoration attributes.
                decoration: InputDecoration(labelText: "Title"),
                // the first listener we have here is the _titleController which
                // saves the value of the Textfield
                controller: _titleController,
                onSubmitted: (_) => _addTransaction(),
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                // the second listener we have here is the _amountController which
                // saves the value of the Textfield
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _addTransaction(),
              ),
              SizedBox(
                height: 70,
                // this row containst the widgets needed for the date picker used in here.
                child: Row(
                  children: <Widget>[
                    // First we have the text that asks to pick a date
                    Text('Pick a date: '),
                    // then we have the button that presents the date picker
                    // for us
                    FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        onPressed: _datePicker,
                        child: Text(
                          _selectedDate == null
                              ? 'Here!'
                              : DateFormat.yMd().format(_selectedDate),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
              Platform.isIOS
                  ? CupertinoButton(
                      child: Text('Add Transaction'),
                      onPressed: _addTransaction)
                  : RaisedButton(
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: _addTransaction,
                      child: Text("Add Transactoin"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
