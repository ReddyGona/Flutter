// ignore_for_file:  prefer_const_constructors_in_immutables, unnecessary_string_interpolations, sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  
  final String label;
  final double spendingAmount;
  final double spendingPercentTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPercentTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: ((context, constraints) {
          return Container(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Container(
                    height: constraints.maxHeight * 0.10,
                    child: FittedBox(
                      child: Text('₹ ${spendingAmount.toStringAsFixed(0)}')
                    )
                  ),
                  SizedBox(height: constraints.maxHeight * 0.04),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    width: 25,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.pink, width: 1),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5) 
                          )
                        ),

                        FractionallySizedBox(
                          heightFactor: spendingPercentTotal,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(5)
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.04),
                  Container(
                    height: constraints.maxHeight * 0.10,
                    child: FittedBox(child: Text(label, style: TextStyle(fontSize: 15),))
                  )
                ],
              ),
            );
        }),
    );
  }
}