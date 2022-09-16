import 'dart:developer';

import 'package:db_sample/DB/data_modal.dart';
import 'package:db_sample/DB/functions/db_function.dart';
import 'package:flutter/cupertino.dart';

class SearchProvider with ChangeNotifier {
  final List<StudentModel> allData = DbFunctions.studentList;
  bool visible = false;
  List<StudentModel> foundData = [];

  Future<void> getAll() async {
    final students = await DbFunctions().getAllStudents();
    foundData = students;
    notifyListeners();
  }

  void searchFilter(String enteredKeyword) {
    List<StudentModel> results = [];
    if (enteredKeyword.isEmpty) {
      log("keyword empty");
      results = allData;
    } else {
      log('searched success');
      results = allData.where((user) {
        return user.username.toLowerCase().contains(
              enteredKeyword.toLowerCase(),
            );
      }).toList();
    }

    foundData = results;
    log('enteried Keyword is Empty');
    notifyListeners();
  }

  void visibilitysearch() {
    if (visible == true) {
      visible = false;
    } else {
      visible = true;
    }
    notifyListeners();
  }

  Future<void> deleteData(String id) async {
    if (id.isEmpty) {
      log('null');
    } else {
      await DbFunctions().deleteList(id.toString());
      log('deleted  oook');
    }

    notifyListeners();
  }
}
