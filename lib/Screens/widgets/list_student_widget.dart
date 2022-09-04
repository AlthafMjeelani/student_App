import 'dart:io';
import 'package:db_sample/DB/functions/db_function.dart';
import 'package:db_sample/Screens/widgets/delete_item.dart';
import 'package:db_sample/Screens/home/view_profile.dart';
import 'package:flutter/material.dart';
import '../../DB/data_modal.dart';

class ListStudentWidget extends StatelessWidget {
  const ListStudentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentListnotifire,
      builder:
          (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
        return Container(
          margin: const EdgeInsets.only(top: 20),
          child: studentList.isEmpty
              ? const Center(
                  child: Text('No Data'),
                )
              : ListView.separated(
                  itemBuilder: (context, index) {
                    final data = studentList[index];
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: FileImage(
                          File(data.photo),
                        ),
                      ),
                      title: Text(data.username),
                      trailing: IconButton(
                        onPressed: () {
                          Delete().deleteItem(context, index);
                        },
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ListStudent(
                              domain: data.domain,
                              age: data.age,
                              name: data.username,
                              mobile: data.mobilenumber,
                              photo: data.photo,
                              index: index,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: studentList.length),
        );
      },
    );
  }
}
