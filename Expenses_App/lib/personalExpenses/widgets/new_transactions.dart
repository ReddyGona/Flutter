// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_null_comparison, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  
  final Function addTnx;

  NewTransaction(this.addTnx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  
  final _titleEditController = TextEditingController();
  final _amountController = TextEditingController();
  
  DateTime? _selectedDate;

  void _submitData(){
    if(_amountController.text.isEmpty){
      return;
    }

    final enterdTitle = _titleEditController.text;
    final enteredAmount = double.parse(_amountController.text);

    if(enterdTitle.isEmpty || enteredAmount <=0 || _selectedDate == null) {
      return; 
    }

    widget.addTnx(enterdTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _datePicker(){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022, 1,1,0,0),
      lastDate: DateTime(2022, 12,31,23, 59)
    ).then((pickedDate){
        if(pickedDate == null){
          return;
        }
        setState(() => _selectedDate = pickedDate );
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
     return SingleChildScrollView(
       child: Card(
                  margin: EdgeInsets.only(
                    top: 10,
                    right: 10,
                    left: 10,
                    bottom: mediaQuery.viewInsets.bottom + 10,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Title'
                          ),
                          controller: _titleEditController,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Amount'
                          ),
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          onSubmitted: (_)=> _submitData(),
                        ),
                        Container(
                          height: 70,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_selectedDate == null ? "No Date Choosen" : DateFormat.yMd().format(_selectedDate!)),
                              TextButton(
                                onPressed: _datePicker,
                                child: Text('Choose Date', style: TextStyle(fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 5
                            ),
                            child: Text('Add Transaction', style: TextStyle(color: Colors.white)),
                            onPressed: _submitData
                        )
                      ],
                    ),
                  ),
               ),
     );
  }
}