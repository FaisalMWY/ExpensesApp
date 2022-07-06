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

  void _datepicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
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
                child: Row(
                  children: <Widget>[
                    Text('Pick a date: '),
                    FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        onPressed: _datepicker,
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
