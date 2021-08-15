import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;

import 'widgets/NewTransaction.dart';
import 'widgets/transactionList.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
        ),
      ),
      title: 'Flutter Expense App',
      home: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("You have error! -- ${snapshot.error.toString()}");
            return Text("You have error!");
          } else if (snapshot.hasData) {
            return MyHomePage();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  fs.CollectionReference fsconnect =
      fs.FirebaseFirestore.instance.collection("expense_app");

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime choosedDate) {
    fsconnect.add({
      'title': txTitle.toString(),
      'amount': txAmount,
      'date': choosedDate ,
      'id': DateFormat('hhmmss').format(DateTime.now()),
    });
    setState(() {
    });
  }

  void addNewTransactionModal(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  void _deleteTransaction(String id) {
    setState(() async {
      var snapshot = await fsconnect.where('id', isEqualTo : id ).get();
      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = AppBar(
      title: Text("Daily Expense App"),
      actions: [
        IconButton(
          onPressed: () {
            null;
          },
          icon: Icon(
            Icons.add,
          ),
        )
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    1,
                child:
                    TransactionList(_deleteTransaction),
              ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => addNewTransactionModal(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
