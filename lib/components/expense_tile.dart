import 'package:flutter/material.dart';
import 'package:extension/extension.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  void Function(BuildContext)? deleteTap;
  ExpenseTile({
    super.key,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.deleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          //delete button
          SlidableAction(
            backgroundColor: Colors.redAccent,
            onPressed: deleteTap,
            icon: Icons.delete,
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          name.capitalizeFirstLetter(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            //color: Color.fromRGBO(53, 56, 57, 1),
            //color: Color.fromRGBO(37, 50, 55, 1),
          ),
        ),
        subtitle: Text(
          "${dateTime.day}-${dateTime.month}-${dateTime.year}",
          style: TextStyle(
            color: Colors.grey[405],
          ),
        ),
        trailing: Text(
          "Rs.$amount",
          style: TextStyle(
            fontSize: 17,
            color: Colors.grey[405],
          ),
        ),
      ),
    );
  }
}
