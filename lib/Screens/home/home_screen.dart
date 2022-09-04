import 'package:db_sample/DB/functions/db_function.dart';
import 'package:db_sample/Screens/search/search_screen.dart';
import 'package:db_sample/Screens/widgets/list_student_widget.dart';
import 'package:flutter/material.dart';
import '../add/add_student_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
            onPressed: () => showSearch(
              context: context,
              delegate: Search(),
            ),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: const [
            Expanded(
              child: ListStudentWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
