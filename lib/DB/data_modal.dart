import 'package:hive_flutter/adapters.dart';
part 'data_modal.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  final String username;
  @HiveField(1)
  final String age;
  @HiveField(2)
  final String mobilenumber;
  @HiveField(3)
  final String domain;
  @HiveField(4)
  final String photo;

  StudentModel({
    required this.username,
    required this.age,
    required this.mobilenumber,
    required this.domain,
    required this.photo,
  });
}
