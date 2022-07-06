import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionsList extends StatelessWidget {
  final List transactions;
  final Function deleteElement;
  const TransactionsList(
      {required this.transactions, required this.deleteElement});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) => Column(
              children: <Widget>[
                SizedBox(
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
        : ListView.builder(
            itemBuilder: (context, index) => Card(
              margin: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 35,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
                  title: Text(
                    '${transactions[index].title}',
                  ),
                  subtitle: Text(
                    DateFormat.yMMMMd().format(transactions[index].date),
                    style: TextStyle(color: Colors.grey),
                  ),
                  trailing: MediaQuery.of(context).size.width > 400
                      ? FlatButton.icon(
                          onPressed: () =>
                              deleteElement(transactions[index].id),
                          textColor: Theme.of(context).errorColor,
                          label: Text('delete'),
                          icon: Icon(Icons.delete))
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
