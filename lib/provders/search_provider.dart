// import 'dart:developer';

// import 'package:db_sample/DB/data_modal.dart';
// import 'package:db_sample/DB/functions/db_function.dart';
// import 'package:flutter/cupertino.dart';

// class SearchProvider with ChangeNotifier {
//   final List<StudentModel> allData = DbFunctions().studentList;

//   List<StudentModel> foundData = [];

//   void searchFilter([String enteredKeyword = '']) {
//     List<StudentModel> results = [];
//     if (enteredKeyword.isEmpty) {
//       results = allData;
//     } else {
//       results = allData.where((user) {
//         log('searched');
//         return user.username.toLowerCase().contains(
//               enteredKeyword.toLowerCase(),
//             );
//       }).toList();
//     }

//     foundData = results;
//     notifyListeners();
//   }
// }
