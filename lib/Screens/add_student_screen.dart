import 'dart:io';
import 'package:db_sample/DB/data_modal.dart';
import 'package:db_sample/DB/functions/db_function.dart';
import 'package:db_sample/provders/provider_imagepic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatelessWidget {
  AddScreen({Key? key}) : super(key: key);

  final bool imageVisibility = false;
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _domain = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                  child: context.watch<ImagePicProvider>().image == null
                      ? const CircleAvatar(
                          backgroundColor: Colors.black38,
                          radius: 60,
                          child: Icon(Icons.image),
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(
                            File(
                              Provider.of<ImagePicProvider>(context,
                                      listen: false)
                                  .image!
                                  .path,
                            ),
                          ),
                          radius: 60,
                        ),
                  // }),
                ),
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
                Visibility(
                  visible: imageVisibility,
                  child: const Text(
                    'please add image',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 40,
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
                            return 'please enter 10 numbers';
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
                          if (formKey.currentState!.validate() &&
                              Provider.of<ImagePicProvider>(context,
                                          listen: false)
                                      .image !=
                                  null) {
                            buttonSubmit(context);
                          } else {
                            // setState(
                            //   () {
                            //     imageVisibility = false;
                            //   },
                            // );
                          }
                        },
                        icon: const Icon(Icons.check),
                        label: const Text('submit'),
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
    if (_userName.text.isEmpty ||
        _age.text.isEmpty ||
        _mobile.text.isEmpty ||
        _domain.text.isEmpty ||
        Provider.of<ImagePicProvider>(context, listen: false)
            .image!
            .path
            .isEmpty) {
      return;
    }
    final student = StudentModel(
        username: _userName.text,
        age: _age.text,
        mobilenumber: _mobile.text,
        domain: _domain.text,
        photo:
            Provider.of<ImagePicProvider>(context, listen: false).image!.path);
    addStudent(student);
    Navigator.of(context).pop();
  }
}
