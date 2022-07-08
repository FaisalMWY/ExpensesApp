import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/transactions.dart';
import 'package:flutter_complete_guide/widgets/chart.dart';
import 'package:flutter_complete_guide/widgets/new_transactions.dart';
import 'package:flutter_complete_guide/widgets/transaction_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expenses App',
      theme: ThemeData(
        // What is the point of primarySwatch?
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold),
            button: TextStyle(color: Colors.white)),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Here we created a List called transactions consisting of datatype

  bool _showChart = false;
  final List<Transaction> _userTransactions = [];
  //This list gets transactions that occured in the last seven days.
  List<Transaction> get _recentTransactions {
    // .where is the condition of which the data gets invoked.
    return _userTransactions
        .where(
          // as we see here, our condition is all days after dateTime.now - 7days
          (element) => element.date.isAfter(
            DateTime.now().subtract(
              Duration(days: 7),
            ),
          ),
        ) //its important to not forget to add tolist in the end, or it wont work.
        .toList();
  }

  // this functino creates a new transaction by giving it the transactoin title
  void _addNewTransaction(
      String transactionTitle, double transactionAmount, DateTime chosenDate) {
    // since we dont have an id generator for the time being we'll use the
    // current date and time
    final newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: transactionTitle,
      amount: transactionAmount,
      date: chosenDate,
    );
    // we need setState to rebuild the view in order to view new transactions
    setState(() {
      // by using .add() we are adding a new item to the list. yes the varialbe
      // is final, but that doesn't mean that the value can not be manupilated.
      _userTransactions.add(newTransaction);
    });
  }

  void startAddNewTransaction(BuildContext buildContext) {
    showModalBottomSheet(
      context: buildContext,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransactions(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    // this value was created to make sure that the orientation is on landscape
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text("personal Expenses"),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              CupertinoButton(
                child: Icon(CupertinoIcons.add),
                onPressed: () => startAddNewTransaction(context),
              ),
            ]),
          ) as ObstructingPreferredSizeWidget
        : AppBar(
            title: Text('Personal Expenses'),
            actions: [
              IconButton(
                onPressed: () => startAddNewTransaction(context),
                icon: Icon(Icons.add),
              )
            ],
          );
    final mainPage = SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            if (isLandscape)
              Center(
                //switch() is a normal switch widget.
                child: Switch.adaptive(
                    // _showchart is our boolean value which is false by default
                    value: _showChart,
                    // since the switch's value affect's the way screen is
                    // viewed, we've put it in set state, and assigned the value
                    // of the new change into _showChart for later use
                    onChanged: (val) {
                      setState(() {
                        // as stated earlier we want to assigne the change of
                        // the switch to the already created _showChart
                        _showChart = val;
                      });
                    }),
              ),
            if (!isLandscape)
              SizedBox(
                  // in order for us to get the absulote size of the main screen
                  // we need to subtract the height of the appbar and the phone's
                  // notification/top bar. and as we see here we've subtracted it
                  // already and we multipied it by.25 because we want to give this
                  // widget 25% of the screen.
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.25,
                  // here we gave the class chart the transactions of the
                  // last 7 days
                  child: Chart(_recentTransactions)),
            // if the screen is not in landscape then the following block of
            // code will be excuted
            if (!isLandscape)
              SizedBox(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.75,
                child: TransactionsList(
                    transactions: _userTransactions,
                    deleteElement: _deleteTransaction),
              ),
            _showChart
                ? SizedBox(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.7,
                    child: Chart(_recentTransactions))
                : SizedBox(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.77,
                    child: TransactionsList(
                        transactions: _userTransactions,
                        deleteElement: _deleteTransaction),
                  ),
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: mainPage,
            navigationBar: (appBar as ObstructingPreferredSizeWidget),
          )
        : Scaffold(
            appBar: appBar,
            body: mainPage,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => startAddNewTransaction(context),
                    child: Icon(
                      Icons.add,
                    ),
                  ),
          );
  }
}
