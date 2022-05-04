// ignore_for_file: deprecated_member_use
// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: prefer_const_constructors
import 'package:flutter/gestures.dart';

import './widgets/new_transaction.dart';
import "package:flutter/material.dart";
import './widgets/transaction_list.dart';
import './models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter App",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [];
  final List<Transaction> _userTransactions = [
    Transaction(
      id: "01",
      title: "New shoes",
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: "02",
      title: "New Computer",
      amount: 203.60,
      date: DateTime.now(),
    ),
  ];

  void _addNewTransaction(String newTitle, double newAmount) {
    final newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: newTitle,
      amount: newAmount,
      date: DateTime.now(),
    );
    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _showInputArea(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          //Do I need the Gesture Detector to avoid closing the input field on tap?
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Expenses App"),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
              ),
              onPressed: () => _showInputArea(context),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: double.infinity,
                child: const Card(
                  color: Colors.blue,
                  child: Text("CHART!"),
                  elevation: 5,
                ),
              ),
              TransactionList(_userTransactions)
            ],
          ),
        ),
        //Set Location of Floating Action Button
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        //Configure Floating Action Button
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _showInputArea(context),
        ));
  }
}
