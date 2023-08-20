import 'package:flutter/material.dart';

class NewTranscation extends StatefulWidget {
  NewTranscation({required this.addTx});
  final Function addTx;

  @override
  State<NewTranscation> createState() => _NewTranscationState();
}

class _NewTranscationState extends State<NewTranscation> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteresTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteresTitle.isEmpty || enteredAmount < 0) {
      return;
    }
    widget.addTx(enteresTitle, enteredAmount);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: titleController,
              onSubmitted: (_) => submitData(),
              // onChanged: (value){
              //    titleInput = value;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
              // onChanged: (value){
              //   amountInput = value;
              // },
            ),
            TextButton(
              onPressed: () => submitData,
              child: Text(
                "Add Transcation",
                style: TextStyle(color: Colors.purple),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
