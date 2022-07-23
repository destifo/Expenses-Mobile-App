import 'dart:io';

import 'package:expenses_app_restarted/widgets/chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../widgets/add_transaction.dart';
import '../widgets/choose_color.dart';
import '../widgets/transaction_list.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  final Function(String title, double amount, DateTime selectedDate)
      addTransaction;
  final Function(String color) changeColor;
  final Function(String id) deleteTx;
  // final titleController = TextEditingController();
  // final amountController = TextEditingController();
  final List<Transaction> transactions;

  MyHomePage(
      {required this.title,
      required this.addTransaction,
      required this.changeColor,
      required this.transactions,
      required this.deleteTx});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  bool _showChart = false;

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  void changeChartSetting(val) {
    setState(() {
      _showChart = val;
    });
  }

  void _openTransactionEntry(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return AddTransaction(addTransaction: widget.addTransaction);
        });
  }

  void openColorSettings(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return ChooseColor(changeColor: widget.changeColor);
        });
  }

  List<Transaction> get _recentTransactions {
    return widget.transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  List<Widget> _buildLandscapeContent(Widget switchButton,
      MediaQueryData mediaQuery, PreferredSizeWidget appBar) {
    return <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Show chart",
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 19),
          ),
          switchButton,
        ],
      ),
      _showChart
          ? Container(
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.65,
              child: Chart(
                recentTransactions: _recentTransactions,
              ),
            )
          : SizedBox(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.8,
              child: TransactionList(
                transactions: widget.transactions,
                deleteTx: widget.deleteTx,
              ),
            )
    ];
  }

  List<Widget> _buildPortraitContent(
      MediaQueryData mediaQuery, PreferredSizeWidget appBar) {
    return <Widget>[
      Container(
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: Chart(
          recentTransactions: _recentTransactions,
        ),
      ),
      SizedBox(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.6,
        child: TransactionList(
          transactions: widget.transactions,
          deleteTx: widget.deleteTx,
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar = AppBar(
      title: Text(widget.title),
      actions: [
        IconButton(
            onPressed: () {
              openColorSettings(context);
            },
            icon: const Icon(Icons.settings))
      ],
    );
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    Widget switchButton = Switch.adaptive(
      onChanged: changeChartSetting,
      value: _showChart,
    );

    final mediaQuery = MediaQuery.of(context);
    final Widget pageBody = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          if (!isLandscape) ..._buildPortraitContent(mediaQuery, appBar),
          if (isLandscape)
            ..._buildLandscapeContent(switchButton, mediaQuery, appBar),
        ],
      ),
    ));

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButton: Platform.isAndroid
                ? FloatingActionButton(
                    onPressed: () {
                      _openTransactionEntry(context);
                    },
                    child: const Icon(Icons.add),
                  )
                : Container(),
          );
  }
}
