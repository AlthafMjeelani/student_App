import 'package:db_sample/DB/functions/db_function.dart';
import 'package:flutter/material.dart';

class Delete {
  
Future<void> deleteItem(BuildContext context, int index) async {
  showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        content: const Text('Permenantly delete your data continue?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () {
              deleteList(index);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                duration: Duration(seconds: 1),
                elevation: 20,
                content: Text(
                  'Records successfully deleted',
                ),
                backgroundColor: Colors.green,
              ));
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

}