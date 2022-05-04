import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercent;

  BarChart(this.label, this.spendingAmount, this.spendingPercent);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      //Fitted Box does not let its child grow but will shrink its content instead
      FittedBox(
          child: Text(
              "€${spendingAmount.toStringAsFixed(0)}")), //Remove decimal places
      SizedBox(height: 4),
      Container(
        height: 60,
        width: 10,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                color: Color.fromRGBO(220, 220, 220, 1),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            FractionallySizedBox(
              heightFactor: spendingPercent,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 4,
      ),
      Text(label),
    ]);
  }
}
