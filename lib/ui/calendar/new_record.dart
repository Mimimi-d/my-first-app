import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewRecord extends StatefulWidget {
  final Function addTx;
  NewRecord(this.addTx);

  @override
  _NewRecordState createState() => _NewRecordState();
}

class _NewRecordState extends State<NewRecord> {
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  DateTime returnDateKey(DateTime day) {
    final dateKey = DateTime(day.year, day.month, day.day);
    return dateKey;
  }

  void submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredAmount = int.parse(_amountController.text);

    setState(() {
      _selectedDate = returnDateKey(DateTime.now());
    });

    if (enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: '時間(分)'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
              // onChanged: (val) => amountInput = val,
            ),
            TextButton(
              onPressed: () => submitData(),
              child: Text(
                'Add Record',
                style:
                    TextStyle(color: Theme.of(context).textTheme.button!.color),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
