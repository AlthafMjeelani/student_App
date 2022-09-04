// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:db_sample/DB/data_modal.dart';
import 'package:db_sample/DB/functions/db_function.dart';
import 'package:db_sample/Screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provders/provider_imagepic.dart';

// ignore: must_be_immutable
class Editscreen extends StatelessWidget {
  Editscreen({
    Key? key,
    required this.index,
    required this.name,
    required this.age,
    required this.mobile,
    required this.domain,
    required this.photo,
  }) : super(key: key);
  final int index;
  final String name;
  final String age;
  final String mobile;
  final String domain;
  final String photo;
  late TextEditingController _userName;
  late TextEditingController _age;
  late TextEditingController _mobile;
  late TextEditingController _domain;

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    _userName = TextEditingController(text: name);
    _age = TextEditingController(text: age);
    _mobile = TextEditingController(text: mobile);
    _domain = TextEditingController(text: domain);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: CircleAvatar(
                      backgroundImage: FileImage(File(
                        Provider.of<ImagePicProvider>(context, listen: true)
                                    .image ==
                                null
                            ? photo
                            : Provider.of<ImagePicProvider>(context,
                                    listen: false)
                                .image!
                                .path,
                      )),
                      radius: 60,
                      child: const Icon(Icons.image),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Provider.of<ImagePicProvider>(context, listen: false)
                            .getimage();
                      },
                      icon: const Icon(Icons.image),
                    ),
                    const Text('Add image'),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Username is Empty';
                          }
                          return null;
                        },
                        controller: _userName,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'FullName'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length > 2) {
                            return 'Age is Not correct formate';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        controller: _age,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Age'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length != 10) {
                            return 'pleas enter 10 number';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        controller: _mobile,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Mobile Number'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'domain is Empty';
                          }
                          return null;
                        },
                        controller: _domain,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Domain'),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            buttonSubmit(context);
                          }
                        },
                        icon: const Icon(Icons.check),
                        label: const Text('save'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> buttonSubmit(BuildContext context) async {
    final student = StudentModel(
      username: _userName.text,
      age: _age.text,
      mobilenumber: _mobile.text,
      domain: _domain.text,
      photo:
          Provider.of<ImagePicProvider>(context, listen: false).image?.path ??
              photo,
    );

    await updateList(index, student);

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
        (route) => false);
  }
}
