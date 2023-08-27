import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/chart.dart';
import 'package:personal_expenses/widgets/new_transcation.dart';
import 'package:personal_expenses/models/transcation.dart';
import 'package:personal_expenses/widgets/transcation_list.dart';
import 'package:personal_expenses/widgets/user_transcation.dart';
import './widgets/new_transcation.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [
  //       DeviceOrientation.portraitUp,
  //       DeviceOrientation.portraitDown,
  //     ]
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "Personal Expenses",
        theme: ThemeData(
          primarySwatch: Colors.purple,

        ),
        debugShowCheckedModeBanner: false,
        home: MyHomePage()
    );
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

  bool _showChart = false;
  final List<Transcation> _userTranscation = [
    // Transcation(
    //     id: "t1", title: "T-Shirt", amount: 555.55, date: DateTime.now()),
    // Transcation(id: "t2", title: "Shirt", amount: 555.55, date: DateTime.now()),
  ];
  List<Transcation> get _recentTranscation {
    return _userTranscation.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }
    ).toList();
  }
  void _addNewTranscation(String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transcation(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: chosenDate);

    setState(() {
      _userTranscation.add(newTx);
    });
    print("Transaction added successfully.");
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

  void _deleteTranscation(String id){
     setState(() {
       _userTranscation.removeWhere((tx) => tx.id == id);
     });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text("Personal Expenses Calculator"),
      actions: [IconButton(onPressed: () => _startAddNewTransaction(context), icon: Icon(Icons.add))],
    );
    final txListWidget =  Container(
        height: (mediaQuery.size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top ) * 0.7,
        child: TranscationList(_userTranscation, _deleteTranscation)
    );
    final pageBody = SingleChildScrollView(
      child: Column(
        children: [
          if(isLandscape)  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Show Chart"),
              Switch.adaptive(value: _showChart, onChanged:(val){
                setState(() {
                  _showChart = val;
                });
              })
            ],
          ),
          if(!isLandscape)
            Container(
                height: (mediaQuery.size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.3,
                child: Chart(_recentTranscation)),
          if(!isLandscape)
            txListWidget,
          if(isLandscape)  _showChart? Container(
              height: (mediaQuery.size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.7,
              child: Chart(_recentTranscation))
              :
          txListWidget,



        ],
      ),
    );
    return Platform.isIOS ? CupertinoPageScaffold(
        child: pageBody, 
    )
        : Scaffold(
      appBar: appBar,
      body:pageBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS? Container()  : FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,

        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
