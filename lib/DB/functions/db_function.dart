import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../data_modal.dart';

ValueNotifier<List<StudentModel>> studentListnotifire = ValueNotifier([]);
Future<void> createDatabase() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(
      StudentModelAdapter(),
    );
  }
}

Future<void> addStudent(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.add(value);
  studentListnotifire.value.add(value);
  studentListnotifire.notifyListeners();
}

Future<void> getAllStudents() async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  studentListnotifire.value.clear();
  studentListnotifire.value.addAll(studentDB.values);
  studentListnotifire.notifyListeners();
}

Future<void> deleteList(int index) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.deleteAt(index);
  getAllStudents();
}

Future<void> updateList(int id, StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.putAt(id, value);
}