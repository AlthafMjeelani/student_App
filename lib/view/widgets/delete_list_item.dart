import 'package:db_sample/view/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/search_provider.dart';

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
                SnackBarWidget().show(context, 'Records successfully Deleted');

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
