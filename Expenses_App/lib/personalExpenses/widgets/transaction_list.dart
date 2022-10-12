// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings,prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_udemy/personalExpenses/models/transaction.dart';
import 'package:flutter_udemy/personalExpenses/widgets/transaction_item.dart';


class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return  transactions.isEmpty? 
             LayoutBuilder(builder: (ctx, constraints){
              return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    Container(
                      height: constraints.maxHeight * 1,
                      padding: const EdgeInsets.all(15),
                      child: Image.asset('assets/images/nodatafound.png', fit: BoxFit.contain),
                    )
                ]);
             }) :  ListView(
                     children: transactions.map((tx) => TransactionItem(
                      key: ValueKey(tx.id),
                      transaction: tx, 
                      mediaQuery: mediaQuery, 
                      deleteTx: deleteTx)
                    ).toList(),
                   );
   
  }
}




