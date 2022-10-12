// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_udemy/personalExpenses/widgets/new_transactions.dart';
import 'package:flutter_udemy/personalExpenses/widgets/transaction_list.dart';

import 'models/transaction.dart';
import './widgets/chart.dart';


main(){
  runApp(Pmain());
}

class Pmain extends StatelessWidget {
  const Pmain({Key? key}) : super(key: key);

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage()
      );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final titleEditController = TextEditingController();
  final amountController = TextEditingController();

   final List<Transaction> _transactions = [
    // Transaction(id: 't1', title: 'OnePlus 9 Pro Max', amount: 50000, date: DateTime.now()),
    // Transaction(id: 't2', title: 'Samsung Galaxy S10 FE', amount: 9000, date: DateTime.now())
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tnx) {
      return tnx.date.isAfter(DateTime.now().subtract(Duration(days: 7),),);
    }).toList();
  }

  void _newTransactions(String txTitle, double txAmount, DateTime choosenDate){
    final newTx = Transaction(id: DateTime.now().toString(), title: txTitle, amount: txAmount, date: choosenDate);

    setState(() {
      _transactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_){
       return GestureDetector(
        onTap: (){},
        behavior: HitTestBehavior.opaque,
        child: NewTransaction(_newTransactions),
        );
    });
  }

  void _deleteTransaction(String id){

    setState(() =>  _transactions.removeWhere((tx) => tx.id == id));

  }

  bool _showChart = false;

  Widget _landScapeWidgets(){
     return Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Show Chart'),
                      Switch(value: _showChart, onChanged: (value) { 
                        setState(() {
                         _showChart = value;
                        });
                      },),
                      ],
                 );
  }

  List<Widget> _potraitWidgets(
   MediaQueryData mediaQuery,
   AppBar apPBar,
   Widget textWidget
  ){
    return [
        Container(
             height: (
                  mediaQuery.size.height -
                  apPBar.preferredSize.height -
                  mediaQuery.padding.top
             ) * 0.3,
            child: Chart(_recentTransactions)
        ), textWidget
    ];
  }

  Widget _landScapeChart (
     MediaQueryData mediaQuery,
     AppBar apPBar,
     Widget textWidget
  ){
    return Container(
              height: (
                mediaQuery.size.height -
                apPBar.preferredSize.height -
                mediaQuery.padding.top
              ) * 0.6,
              child: Chart(_recentTransactions)
     ); 
  }



  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
     final isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
     final apPBar =  AppBar(
               title: Text('Flutter App'),
                  actions: [
                     IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => _startAddNewTransaction(context),
                     )],
                backgroundColor: Theme.of(context).primaryColor,
        );

      final textWidget = Container(
                      height : (
                          mediaQuery.size.height -
                          apPBar.preferredSize.height 
                          // mediaQuery.padding.top
                      ) * 0.7,
                    child: TransactionList(_transactions, _deleteTransaction)
                  );

    return Scaffold(
     appBar: apPBar,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                     if(isLandScape) _landScapeWidgets(),
      
                     if(!isLandScape) ..._potraitWidgets(mediaQuery, apPBar, textWidget),

                     if(isLandScape) _showChart ?  _landScapeChart(mediaQuery, apPBar, textWidget) : textWidget
                ],
              ),
        ),
      ),
      );
  }
}