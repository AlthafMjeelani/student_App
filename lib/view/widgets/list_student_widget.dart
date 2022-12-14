import 'dart:developer';
import 'dart:io';
import 'package:db_sample/view/home/view_profile.dart';
import 'package:db_sample/view/widgets/delete_list_item.dart';
import 'package:db_sample/providers/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListStudentWidget extends StatelessWidget {
  const ListStudentWidget({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Consumer<SearchProvider>(
        builder: (BuildContext context, SearchProvider value, Widget? child) {
          return value.foundData.isEmpty
              ? const Center(
                  child: Text('No Data'),
                )
              : ListView.separated(
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    final data = value.foundData[index];
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
                          DeleteItemList.deleteItem(
                            context,
                            data.id.toString(),
                            controller,
                          );

                          log('delete called');
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
                              id: data.id.toString(),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: value.foundData.length,
                );
        },
      ),
    );
  }
}
