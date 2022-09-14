import 'dart:developer';

import 'package:db_sample/DB/data_modal.dart';
import 'package:db_sample/DB/functions/db_function.dart';
import 'package:db_sample/Screens/widgets/list_student_widget.dart';
import 'package:db_sample/provders/provider_imagepic.dart';
import 'package:db_sample/provders/search_provider.dart';
import 'package:db_sample/provders/search_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../add/add_student_screen.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log(' build called');

    // WidgetsBinding.instance.addPostFrameCallback(
    //   (timeStamp) {
    //     return context.watch<SearchProvider>().searchFilter('');
    //   },
    // );
    Provider.of<DbFunctions>(context, listen: false).getAllStudents();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ImagePicProvider>().image = null;
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (cxt) => AddScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Student List'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.close),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child:
            //   CupertinoSearchTextField(
            //     autofocus: true,
            //     backgroundColor: Colors.grey.withOpacity(0.5),
            //     suffixIcon: const Icon(
            //       CupertinoIcons.xmark_circle_fill,
            //       color: Colors.grey,
            //     ),
            //     prefixIcon: const Icon(
            //       CupertinoIcons.search,
            //       color: Colors.grey,
            //     ),
            //     style: const TextStyle(color: Colors.white),
            //     onChanged: (value) {
            //       // Provider.of<DbFunctions>(context, listen: false)
            //       //     .studentList(value);
            //     },
            //   ),
            // ),
            const Expanded(
              child: ListStudentWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
