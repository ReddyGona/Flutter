// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';


class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.mediaQuery,
    required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final MediaQueryData mediaQuery;
  final Function deleteTx;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {

  late Color _bgColor;

  @override
  void initState() {
    const avalableColors = [
      Colors.red,
      Colors.blue,
      Colors.cyan,
      Colors.deepOrange
    ];
     
    _bgColor = avalableColors[Random().nextInt(5)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 10, left: 15, right: 15),
      elevation: 5,
      child: ListTile(
        leading: Container(
          alignment: Alignment.center,
          height: 40,
          width: 90,
          color: _bgColor,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: FittedBox(child: Text('₹ ${widget.transaction.amount}', style: TextStyle(fontSize: 17, color: Colors.white),)),
          ),
        ),
        title: Text(widget.transaction.title),
        subtitle: Text(DateFormat.yMMMd().format(widget.transaction.date)),
        trailing: widget.mediaQuery.size.width > 400 
         ? TextButton.icon(
          icon: Icon(Icons.delete, color: Colors.white),
          label: Text('Delete', style: TextStyle(color: Colors.white)),
          style: TextButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () => widget.deleteTx(widget.transaction.id)                      
         )
         : IconButton(
          icon: Icon(Icons.delete),
          color: Colors.red,
          iconSize: 30,
          onPressed: () => widget.deleteTx(widget.transaction.id)
        ),
      ),
    );
  }
}