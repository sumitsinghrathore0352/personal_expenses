import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/new_transcation.dart';
import 'package:personal_expenses/models/transcation.dart';
import 'package:personal_expenses/widgets/transcation_list.dart';
import 'package:personal_expenses/widgets/user_transcation.dart';
import './widgets/new_transcation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String? titleInput;s
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  final List<Transcation> _userTranscation = [
    Transcation(
        id: "t1", title: "T-Shirt", amount: 555.55, date: DateTime.now()),
    Transcation(id: "t2", title: "Shirt", amount: 555.55, date: DateTime.now()),
  ];
  void _addNewTranscation(String txTitle, double txAmount) {
    final newTx = Transcation(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: DateTime.now());

    setState(() {
      _userTranscation.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
             onTap: (){
               print("new transcation added");
             },
              child: NewTranscation(addTx: _addNewTranscation),
              behavior: HitTestBehavior.opaque,
          );

        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Expenses Calculator"),
        actions: [IconButton(onPressed: () => _startAddNewTransaction(context), icon: Icon(Icons.add))],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Card(
                child: Text("CHART"),
                elevation: 5,
              ),
            ),
            TranscationList(_userTranscation),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
