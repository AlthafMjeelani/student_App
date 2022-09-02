import 'dart:io';
import 'package:db_sample/DB/functions/db_function.dart';
import 'package:db_sample/Screens/widgets/view_profile.dart';
import 'package:flutter/material.dart';
import '../DB/data_modal.dart';

class Search extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, query);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentListnotifire,
      builder:
          (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
        return Container(
          margin: const EdgeInsets.only(top: 20),
          child: studentList.isEmpty
              ? const Center(
                  child: Text('No Result'),
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    final data = studentList[index];
                    if (data.username.toLowerCase().contains(
                          query.toLowerCase(),
                        )) {
                      return Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: FileImage(
                                File(data.photo),
                              ),
                            ),
                            title: Text(data.username),
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
                          ),
                          const Divider(),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                  itemCount: studentList.length,
                ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentListnotifire,
      builder:
          (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
        return Container(
          margin: const EdgeInsets.only(top: 20),
          child: ListView.builder(
            itemCount: studentList.length,
            itemBuilder: (context, index) {
              final data = studentList[index];
              if (data.username.toLowerCase().contains(
                    query.toLowerCase(),
                  )) {
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: FileImage(
                          File(data.photo),
                        ),
                      ),
                      title: Text(data.username),
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
                    ),
                    const Divider(),
                  ],
                );
              } else {
                return Container();
                // Text('no data');
              }
            },
          ),
        );
      },
    );
  }
}
