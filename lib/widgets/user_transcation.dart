// import 'package:flutter/material.dart';
// import 'package:personal_expenses/models/transcation.dart';
//
// import 'transcation_list.dart';
// import 'new_transcation.dart';
//
// class UserTranscation extends StatefulWidget {
//      UserTranscation({Key? key}) : super(key: key);
//
//   @override
//   State<UserTranscation> createState() => _UserTranscationState();
// }
//
// class _UserTranscationState extends State<UserTranscation> {
//   final List<Transcation> _userTranscation = [
//     Transcation(
//         id: "t1", title: "T-Shirt", amount: 555.55, date: DateTime.now()),
//     Transcation(id: "t2", title: "Shirt", amount: 555.55, date: DateTime.now()),
//   ];
//   void _addNewTranscation(String txTitle , double txAmount){
//    final newTx = Transcation(
//        id: DateTime.now().toString(),
//        title: txTitle,
//        amount: txAmount,
//        date: DateTime.now());
//
//       setState(() {
//         _userTranscation.add(newTx);
//       });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         NewTranscation(addTx: _addNewTranscation),
//         TranscationList(_userTranscation),
//       ],
//     );
//   }
// }//
