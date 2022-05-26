import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/transactions.dart';
import 'package:flutter_complete_guide/widgets/user_transactions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses Application',
      theme: ThemeData(
        // What is the point of primarySwatch?
        primarySwatch: Colors.lightBlue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  // Here we created a List called transactions consisting of datatype
  // transaction which is a class created to invoke data from the user
  final List<transaction> transactions = [
    transaction(id: '1', title: "food", amount: 69.99, date: DateTime.now()),
    transaction(id: '2', title: "socks", amount: 19.99, date: DateTime.now())
  ];
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget Playground!'),
      ),
      // SingleChildView was created to have a scrollable screen. if it does not
      // exist, when items exceed the height of the screen an error would occur.
      body: SingleChildScrollView(
        // a scrollDirection must be set or else the screen wont scroll.
        scrollDirection: Axis.vertical,
        // a column was created to items sorted from top to bottom.
        child: Column(
          children: <Widget>[
            // to create a space between the widget and the appbar
            SizedBox(height: 10),
            //center was created to centralize the widget
            Center(
              // container to contain the widget and decorate it since thats
              child: Container(
                // one of clipBehavor's uses is to set the shadow underneath
                // the widget behavior. Clip.none will make sure that the shadow
                // will not be cut.
                clipBehavior: Clip.none,
                // the height of the widget
                height: 90,
                // the width of the widget
                width: 300,
                // card widget that creates a card
                child: Card(
                  // color: sets the color of the card
                  color: Colors.blue,
                  // in this case elevation controls the strength of the shadow
                  elevation: 5,
                  // container can only have one child in this case its text
                  // and its centered
                  child: Center(child: Text('expenses')),
                ),
              ),
            ),
            // instead of having a really long main file filled with many
            // widgets we decided to split them into different widgets and add
            // them together in UserTransaction()
            UserTransactions(),
          ],
        ),
      ),
    );
  }
}
