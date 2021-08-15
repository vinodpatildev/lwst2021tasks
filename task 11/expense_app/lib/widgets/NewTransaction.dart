import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final void Function(String title, double amount, DateTime choosedDate)
      addNewTransaction;
  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _amountController = TextEditingController();
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();

  late DateTime _choosedDate;

  void submitTransaction() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    widget.addNewTransaction(
      enteredTitle,
      enteredAmount,
      _choosedDate,
    );
    _choosedDate = DateTime.now();
    Navigator.of(context).pop();
  }

  void pushDateModal() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((choosedDate) {
      String choosedDateStr = DateFormat.yMd().format(choosedDate!);
      _dateController.value = _dateController.value.copyWith(
        text: choosedDateStr,
        selection: TextSelection.collapsed(offset: choosedDateStr.length),
      );
      _choosedDate = choosedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            left: 10,
            right: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Center(
                child: Text(
                  "Add Transaction Details",
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "title",
                ),
                controller: _titleController,
                keyboardType: TextInputType.text,
                // onSubmitted: (_) => submitTransaction(),
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                controller: _amountController,
                keyboardType: TextInputType.number,
                // onSubmitted: (_) => submitTransaction(),
              ),
              TextField(
                decoration: InputDecoration(labelText: "date"),
                controller: _dateController,
                onTap: pushDateModal,
                readOnly: true,
                // onSubmitted: (_) => submitTransaction(),
              ),
              ElevatedButton(
                
                onPressed: submitTransaction,
                child: Text("Add Transaction."),
              ),
            ],
          ),
        ),
        elevation: 5,
      ),
    );
  }
}
