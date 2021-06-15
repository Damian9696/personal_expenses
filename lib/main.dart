import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/widgets/chart.dart';
import 'package:personal_expenses/widgets/new_transaction.dart';
import 'package:personal_expenses/widgets/transaction_list.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.orange,
          accentColor: Colors.lime,
          fontFamily: "Quicksand",
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              button: TextStyle(color: Colors.white)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 20,
                      fontWeight: FontWeight.bold)))),
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    // Transaction(
    //     id: "0", title: "New shoes", amount: 23.43, date: DateTime.now()),
    // Transaction(id: "1", title: "Car", amount: 150.00, date: DateTime.now())
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(
      String newTitle, double newAmount, DateTime chosenDate) {
    final newTransaction = Transaction(
        id: DateTime.now().toString(),
        title: newTitle,
        amount: newAmount,
        date: chosenDate);

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  void _startProcessOfAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);

    final _isLandscape = _mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget _appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Flutter App',
              // style: TextStyle(fontFamily: "OpenSans"),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startProcessOfAddNewTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            title: Text(
              'Flutter App',
              // style: TextStyle(fontFamily: "OpenSans"),
            ),
            actions: [
              IconButton(
                  onPressed: () => _startProcessOfAddNewTransaction(context),
                  icon: Icon(Icons.add))
            ],
          );

    final _transactionList = Container(
        height: (_mediaQuery.size.height -
                _mediaQuery.padding.top -
                _appBar.preferredSize.height) *
            0.7,
        child: TransactionList(_transactions, _deleteTransaction));

    final _body = SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Show Chart"),
                Switch.adaptive(
                  activeColor: Theme.of(context).accentColor,
                  value: _showChart,
                  onChanged: (val) {
                    setState(() {
                      _showChart = val;
                    });
                  },
                )
              ],
            ),
          if (!_isLandscape)
            Container(
                height: (_mediaQuery.size.height -
                        _mediaQuery.padding.top -
                        _appBar.preferredSize.height) *
                    0.3,
                child: Chart(_recentTransactions)),
          if (!_isLandscape) _transactionList,
          if (_isLandscape)
            _showChart
                ? Container(
                    height: (_mediaQuery.size.height -
                            _mediaQuery.padding.top -
                            _appBar.preferredSize.height) *
                        0.7,
                    child: Chart(_recentTransactions))
                : _transactionList,
        ],
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: _body,
            navigationBar: _appBar,
          )
        : Scaffold(
            appBar: _appBar,
            body: _body,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _startProcessOfAddNewTransaction(context),
                    child: Icon(Icons.add),
                  ),
          );
  }
}
