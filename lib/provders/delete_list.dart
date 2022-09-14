import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../DB/functions/db_function.dart';

class Delete with ChangeNotifier {
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
                DbFunctions().deleteList(index);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(seconds: 1),
                  elevation: 20,
                  content: Text(
                    'Records successfully deleted',
                  ),
                  backgroundColor: Colors.green,
                ));
                Provider.of<DbFunctions>(context, listen: false)
                    .getAllStudents();
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
