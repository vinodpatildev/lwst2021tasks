import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;

import 'package:expense_app/widgets/transactionCard.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final void Function(String id) deleteTransaction;
  final Stream<fs.QuerySnapshot> usersStream =
      fs.FirebaseFirestore.instance.collection('expense_app').snapshots();

  TransactionList(this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<fs.QuerySnapshot>(
      stream: usersStream,
      builder:
          (BuildContext context, AsyncSnapshot<fs.QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((fs.DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return TransactionCard(Transaction(
                id: data['id'],
                title: data['title'],
                amount: data['amount'],
                date: data['date'].toDate()),
                deleteTransaction);
          }).toList(),
        );
      },
    );
  }
}
