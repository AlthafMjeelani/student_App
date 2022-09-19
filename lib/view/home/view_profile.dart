import 'dart:io';
import 'package:db_sample/DB/model/enum.dart';
import 'package:db_sample/view/add/add_student_screen.dart';
import 'package:flutter/material.dart';

class ListStudent extends StatelessWidget {
  const ListStudent({
    Key? key,
    required this.name,
    required this.age,
    required this.mobile,
    required this.domain,
    required this.photo,
    required this.index,
    required this.id,
  }) : super(key: key);
  final String name;
  final String age;
  final String mobile;
  final String domain;
  final String photo;
  final int index;
  final String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color.fromARGB(59, 76, 100, 137),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          height: 300,
                          width: 350,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(
                                File(photo),
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        "FullName : $name",
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Age : $age",
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Mobile Number : $mobile",
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Domain : $domain",
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AddScreen(
                                name: name,
                                age: age,
                                domain: domain,
                                mobile: mobile,
                                photo: photo,
                                id: id.toString(),
                                type: Actiontype.editScreen,
                                index: index,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text('edit'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
