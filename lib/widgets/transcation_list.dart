import 'package:flutter/material.dart';
import '../models/transcation.dart';
import 'package:intl/intl.dart';


class TranscationList extends StatelessWidget {

      final List<Transcation> transcation ;
      final Function deleteTx;
      TranscationList(this.transcation, this.deleteTx);

      @override
  Widget build(BuildContext context) {
  return transcation.isEmpty? LayoutBuilder(builder: (ctx , constraints ){
   return Column(
      children: [

        Container(
            height:constraints.maxHeight * 0.6,
            child: Image.network(
              "https://cdn3d.iconscout.com/3d/premium/thumb/transaction-4996080-4159677.png",
              fit: BoxFit.cover,
            )),
        SizedBox(
          height: 10,
        ),
        Text("No transcation added yet! ",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }): ListView.builder(

        itemBuilder: (ctx, index){
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 5 ,vertical: 8),
            elevation:5,
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: FittedBox(

                    child: Text("\$${transcation[index].amount}",
                    ),

                  ),
                ),
              ),
              title: Text("${transcation[index].title}",
                      style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                DateFormat.yMMMd().format(transcation[index].date),
              ),
              trailing:MediaQuery.of(context).size.width >460 ? ElevatedButton.icon(onPressed: () => deleteTx(transcation[index].id),
                icon: Icon(Icons.delete),
                  label: Text("Delete"),
                 style: ButtonStyle(
                   backgroundColor: MaterialStateProperty.all(Colors.white),
                  foregroundColor: MaterialStateProperty.all(Colors.red)
                 ),
              )
                  :
              IconButton(
                onPressed: () => deleteTx(transcation[index].id),
                icon: Icon(Icons.delete),
                color: Colors.red,
              ),
            ),
          );
        },
        itemCount: transcation.length,


    );
  }
}
// Card(
// child: Row(
// children: [
// Container(
// margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
// decoration: BoxDecoration(
// border: Border.all(
// color: Theme.of(context).primaryColor,
// width: 2,
// ),
// ),
// padding: EdgeInsets.all(10),
// child: Text(
// "\$ ${transcation[index].amount.toStringAsFixed(2)}",
// style: TextStyle(
// fontWeight: FontWeight.bold,
// fontSize: 20,
// color: Theme.of(context).primaryColor,
// ),
// ),
// ),
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// transcation[index].title,
// style: TextStyle(
// fontSize: 18,
// fontWeight: FontWeight.bold,
// ),
// ),
// Text(
// DateFormat.yMMMd().format(transcation[index].date),
// style: TextStyle(
// color: Colors.grey,
// ),
// ),
// ],
// ),
// ],
// ),
// );