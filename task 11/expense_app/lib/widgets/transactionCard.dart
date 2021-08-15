import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionCard extends StatelessWidget {
  final Transaction tx;
  final void Function(String id) deleteTransaction;
  TransactionCard(this.tx, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            width: 90,
            child: Text('\$' + tx.amount.toStringAsFixed(0),
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),
            ),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  tx.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  child: Text(
                    tx.id + " ",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    DateFormat.yMEd().format(tx.date),
                  ),
                  margin: EdgeInsets.all(4),
                ),
              ],
            ),
          ]),

          IconButton(
            onPressed: () => deleteTransaction(tx.id),
            icon: Icon(Icons.delete,
            color: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
      elevation: 5,
    );
  }
}
