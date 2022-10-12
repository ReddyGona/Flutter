// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_udemy/personalExpenses/models/transaction.dart';
import 'package:flutter_udemy/personalExpenses/widgets/chart_bar.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  

  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues{
     return List.generate(7, (index){
      final weekDay = DateTime.now().subtract(Duration(days: index));

          var totalSum = 0.0;

          for(var i=0; i<recentTransactions.length; i++){
            if(recentTransactions[i].date.day == weekDay.day &&
               recentTransactions[i].date.month == weekDay.month &&
               recentTransactions[i].date.year == weekDay.year
            ){
               totalSum += recentTransactions[i].amount;
            }
          }

          return {'day': DateFormat.E().format(weekDay).substring(0,1), 'amount': totalSum};
     }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0, (acc, i){
        double abc = i['amount'] as double;
        return acc+abc;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
         margin: EdgeInsets.only(top: 10, left: 15, right: 15),
         child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((e) {
            return Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                          e['day'].toString(),
                          e['amount'] as double, 
                          totalSpending == 0.0 ? 0.0 : (e['amount'] as double)/ totalSpending),
                  );       
              }).toList(),
            )
      );
  }
}