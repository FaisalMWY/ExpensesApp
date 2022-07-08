import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionsList extends StatelessWidget {
  final List transactions;
  final Function deleteElement;
  const TransactionsList(
      {required this.transactions, required this.deleteElement});

  @override
  Widget build(BuildContext context) {
    // this is a condition that checks if there are any items in the list.
    // if not then it'll show a picture
    return transactions.isEmpty
        // LayoutBuilder helps in knowing the dimensions of the used device
        ? LayoutBuilder(
            builder: (context, constraints) => Column(
              children: <Widget>[
                // this SizedBox is given 60% of the screens size which holds
                // the image that appears when no transaction was found.
                SizedBox(
                  // constraints.maxHeight gives the maximum height of the used
                  // widget and by multiplying it by .6 we're getting 60% of the
                  // widget space.
                  height: constraints.maxHeight * .6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 10),
                Text('No transactions yet!')
              ],
            ),
          )
        // now this is the else part for the condition created earlier
        : ListView.builder(
            itemBuilder: (context, index) => Card(
              margin: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                // list tile is a convenient widget that can replace a card
                // widget. however, when we need to highly customize a window,
                // its better to use a container or card since they are highley
                // custmizable unlike ListTile
                child: ListTile(
                  // leading is the widget that lies in the beginning of the tile
                  // in our example we want to show the amount of money spent in
                  // a transaction first thust we've put it in a CircleAvater.
                  // as it fits well in our situation
                  leading: CircleAvatar(
                    radius: 35,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      // as we can see here we've put the amount of money with
                      // a fixed number of decimals which is 2.
                      child: FittedBox(
                        child: Text(
                          '\$${transactions[index].amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // after the leading widget we have a title.
                  title: Text(
                    '${transactions[index].title}',
                  ),
                  // then after the title we can have a subtitle that lies
                  // beneath the title
                  subtitle: Text(
                    DateFormat.yMMMMd().format(transactions[index].date),
                    style: TextStyle(color: Colors.grey),
                  ),
                  // trailing lies in the end of the tile in our case its the
                  // delete button.
                  // as we can see here we have a condition which checks whether
                  // the width is greater than 400 or not,
                  // if its greater the view will differ.
                  // MediaQuery helps with widget sizing, its way more accurate
                  // and convenient. instead of sizing widgets by using pixels
                  // sizing now happens with giving a percentage of the screen.
                  trailing: MediaQuery.of(context).size.width > 400
                      // the first condition will show the text 'delete'
                      ? FlatButton.icon(
                          onPressed: () =>
                              // deleteElement deletes a transaction from a list
                              deleteElement(transactions[index].id),
                          textColor: Theme.of(context).errorColor,
                          label: Text('delete'),
                          icon: Icon(Icons.delete))
                      // the second condition will only show the delete Icon
                      : IconButton(
                          color: Theme.of(context).errorColor,
                          icon: Icon(Icons.delete),
                          onPressed: () =>
                              deleteElement(transactions[index].id),
                        ),
                ),
              ),
            ),
            itemCount: transactions.length,
          );
  }
}
