import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionsList extends StatelessWidget {
  final List Transactions;
  const TransactionsList({required this.Transactions});

  @override
  Widget build(BuildContext context) {
    return Column(
      // here transactions creates a list of widgets from the list
      // transactions. .map almost always takes a function, which will
      // be executed for every object/widget in the list.
      // in our case we have tx, tx is an argument for the function.
      // which represents a transaction.
      children: Transactions.map((tx) {
        // for each tx we'll return a card with its attributes as
        // presented here
        return Card(
          // the card will have the widgets sorted from left to right in
          // a row
          child: Row(
            children: <Widget>[
              // the first widget in the left will be a container
              Container(
                // margin is an empty space surrounding the
                // widget, padding and border
                margin:
                    // EdgeInsets usually creates a space, so here we
                    // are creating space with 10px vertically, and 15px
                    // horizontally
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                // the same goes for padding with the margin. however,
                // the padding is underneath the margin.
                padding: EdgeInsets.all(10),
                // what makes containers special from some other widgets
                // is the ability to decorate it as we can see here
                // we are decorating it useing the decoration
                decoration: BoxDecoration(
                  // creates a border
                  border: Border.all(
                    // in this case the color is an attribute in
                    // Border.all which sets the color.
                    color: Colors.deepPurpleAccent,
                    // width here determines the width of the border
                    width: 2,
                  ),
                ),
                // this text is a child of the contaner. the point of it
                // here is to show the amount of money spent a
                // transactoin
                child: Text(
                  // typing $ in a quotes while typing a variable after
                  // it, converts the variable into string. Like here
                  // for example, the tx.amount is an intiger but when
                  // adding a dollar sign before it the intiger is
                  // converted to a string
                  '\$${tx.amount}',
                  // style is an attribute responsible of styling the
                  // text
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.deepPurpleAccent),
                ),
              ),
              // this column was created to have the name of the
              // transaction and the date underneath it
              Column(
                // crossAxisAlignment is responsible of how widgets are
                // alligned horizontally
                // its important to note that cross axis alignment acts
                // differently with a row widget, since
                // crossAxisAllignment in there is responsible of how
                // widgets are alligned vertically.
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // this text contains the title of the transaction
                  Text(
                    '${tx.title}',
                    style: TextStyle(fontSize: 16),
                  ),
                  // this text contains the date of the transaction.
                  // its important to note that DateFormat.yMMMMd()
                  // is an imported package that helps formatting
                  // the date in a nice way.
                  Text(
                    DateFormat.yMMMMd().format(tx.date),
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              )
            ],
          ),
        );
        // when creating a .map list we need to put after the closing
        // prantheses .list
      }).toList(),
    );
  }
}
