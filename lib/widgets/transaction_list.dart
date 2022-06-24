import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionsList extends StatelessWidget {
  final List transactions;
  const TransactionsList({required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 10),
                Text('No transactions yet!')
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) => Card(
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
                          color: Theme.of(context).primaryColor,
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
                        '\$${transactions[index].amount.toStringAsFixed(2)}',
                        // style is an attribute responsible of styling the
                        // text
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Theme.of(context).primaryColor,
                        ),
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
                          '${transactions[index].title}',
                          style: TextStyle(fontSize: 16),
                        ),
                        // this text contains the date of the transaction.
                        // its important to note that DateFormat.yMMMMd()
                        // is an imported package that helps formatting
                        // the date in a nice way.
                        Text(
                          DateFormat.yMMMMd().format(transactions[index].date),
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              itemCount: transactions.length,
            ),
    );
  }
}
