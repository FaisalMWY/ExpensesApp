import 'package:flutter/material.dart';
import '../models/transactions.dart';
import './new_transactions.dart';
import './transaction_list.dart';

class UserTransactions extends StatefulWidget {
  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  // Here we created a List called transactions consisting of datatype
  // transaction which is a class created to invoke data from the user
  final List<transaction> _userTransactions = [
    // transaction(id: '1', title: "food", amount: 69.99, date: DateTime.now()),
    // transaction(id: '2', title: "socks", amount: 19.99, date: DateTime.now())
  ];
  // this functino creates a new transaction by giving it the transactoin title
  // and amount
  void _addNewTransaction(String transactionTitle, double transactionAmount) {
    // since we dont have an id generator for the time being we'll use the
    // current date and time
    final newTransaction = transaction(
      id: DateTime.now().toString(),
      title: transactionTitle,
      amount: transactionAmount,
      date: DateTime.now(),
    );
    // we need setState to rebuild the view in order to view new transactions
    setState(() {
      // by using .add() we are adding a new item to the list. yes the varialbe
      // is final, but that doesn't mean that the value can not be manupilated.
      _userTransactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    // rather than having both of those widgets in the main screen widgets got
    // distrebuted to maintain an effecient and convenient environment.
    return Column(
      children: <Widget>[
        // _addNewTransaction was passed to newTransactions to recieve the
        // values of the title and the amount
        NewTransactions(_addNewTransaction),
        // the list being passed to TransactionList to give it the list contents
        TransactionsList(Transactions: _userTransactions),
      ],
    );
  }
}
