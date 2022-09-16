import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provders/search_provider.dart';

class DeleteItemList {
  static Future<void> deleteItem(BuildContext context, String index,
      TextEditingController controller) async {
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
                Provider.of<SearchProvider>(context, listen: false)
                    .deleteData(index.toString());
                controller.clear();
                Provider.of<SearchProvider>(context, listen: false).getAll();
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
