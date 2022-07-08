import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/transactions.dart';
import 'package:flutter_complete_guide/widgets/chart_bar.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  const Chart(this.recentTransactions);
  // this getter creates seven lists as spicified in here
  // v <== this is an arrow pointing at (List) which is the spicified object
  List<Map<String, Object>> get groupedTransactionValues {
    // we generated seven elements in the generator because we want to generate
    // an element for each day of the week
    return List.generate(7, (index) {
      // weekDay spicifies the weekday by subtracting the index from
      // DateTime.now so if today is sunday and we subtract one then the weekday
      // is saturday, then the lines of codes after will calculate for saturday
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      // this for loop will go through each element in recent transactions
      // , then finds transactions that have occured in saturday, then finally
      // calculates the total.
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      // finally we will return the specified object stated earlier in line 10
      // it was a list that contains a list of Maps which consists of a String
      // which is (day) and (amount) and object which is
      // DateFormat.E().format(weekDay).substring(0, 1), and total sum.
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
      // we added reversed in order to show the results in reversed order.
      // then we added toList to add the calculated valuse to a list.
    }).reversed.toList();
  }

  // this getter uses .fold to calcutlate the total spending of the current week
  double get maxSpending {
    // as we see here .fold takes to arguments the first being initialValue and
    // the second being startingValue and element
    return groupedTransactionValues.fold(0.0, (startingValue, item) {
      return groupedTransactionValues.fold(
          0.0,
          (previousValue, element) =>
              previousValue + (element['amount'] as double));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      // elevation here acts as a shadow for the card the higher
      // the harder/thicker the shadow is.
      elevation: 6,
      // margin gives space around the widget from outside
      margin: EdgeInsets.all(20),
      // while padding gives space between the border of the widget
      // and its contents
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // Usually we'll use Children [] with square brackets but here
          // we used a map immediately why? Because this Row only contains this
          // list, and there are no other contents thus we used
          // the groupedTransactionValues List
          children: groupedTransactionValues.map((bar) {
            // expanded might not be effective here since all children are sized
            // and spcaed evenly. but the point of expanded is to give a widget
            // as much space as it can take.
            return Expanded(
              // since this code is written in a map then each element in the
              // map will give the ChartBar class the day and the spending
              // amount of that day, and the average of spending of the week.
              child: ChartBar(
                  (bar['day'] as String),
                  (bar['amount'] as double),
                  maxSpending == 0 //since in the beginning We'll have 0 max
                      ? 0.0 //spending we are putting a condition to prevent deviding by 0
                      : (bar['amount'] as double) /
                          maxSpending), //<== we dont want to devide by 0.
            ); // we should never forget to add toList in the end of the map.
          }).toList(),
        ),
      ),
    );
  }
}
