import './bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionAmounts {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var totalSum = 0.0;

//Try: for var in recenttransactions
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        "day": DateFormat.E().format(weekDay).substring(
            0, 2), //Substring shows only those characters from string
        "amount": totalSum,
      };
    });
  }

  double get totalSpending {
    return groupedTransactionAmounts.fold(0.0, (sum, item) {
      return sum + (item["amount"] as num);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionAmounts.map((entry) {
            return Flexible(
              //Flexfit makes sure all children take up the same amount of space
              fit: FlexFit.tight,
              child: BarChart(
                entry["day"] as String,
                entry["amount"] as double,
                totalSpending == 0.0
                    ? 0.0
                    : (entry["amount"] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
