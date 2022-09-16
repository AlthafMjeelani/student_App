import 'dart:developer';
import 'dart:io';
import 'package:db_sample/DB/data_modal.dart';
import 'package:db_sample/DB/functions/db_function.dart';
import 'package:db_sample/providers/provider_imagepic.dart';
import 'package:db_sample/providers/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/add_screen_widget.dart';

class AddScreen extends StatelessWidget {
  AddScreen({Key? key}) : super(key: key);

  final TextEditingController _userName = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _domain = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final imageprovider = Provider.of<ImagePicProvider>(context, listen: false);
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
                  child: Provider.of<ImagePicProvider>(context, listen: true)
                              .image ==
                          null
                      ? const CircleAvatar(
                          backgroundColor: Colors.black38,
                          radius: 60,
                          child: Icon(Icons.image),
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(
                            File(
                              imageprovider.image!.path,
                            ),
                          ),
                          radius: 60,
                        ),
                ),
                Consumer<ImagePicProvider>(
                    builder: (BuildContext context, value, Widget? child) {
                  return Visibility(
                    visible: value.imageVisibility,
                    child: const Center(
                      child: Text(
                        'Please add Image',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        imageprovider.getimage();
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
                      AddTextFormFeild(
                        userName: _userName,
                        age: _age,
                        mobile: _mobile,
                        domain: _domain,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (formKey.currentState!.validate() &&
                              imageprovider.image != null) {
                            buttonSubmit(context);
                            imageprovider.imageVisibility = false;
                          } else {
                            if (imageprovider.image != null) {
                              imageprovider.isVisible(imageprovider.image);
                            } else {
                              imageprovider.isVisible(imageprovider.image);
                            }
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
    final imageprovider = Provider.of<ImagePicProvider>(context, listen: false);
    final finctionprovider = Provider.of<DbFunctions>(context, listen: false);
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
      photo: imageprovider.image!.path,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    );

    finctionprovider
        .addStudent(student)
        .then((value) => imageprovider.image = null);
    log('saved');
    Provider.of<SearchProvider>(context, listen: false).getAll();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      duration: Duration(seconds: 1),
      elevation: 20,
      content: Text(
        'Records successfully Added',
      ),
      backgroundColor: Colors.green,
    ));

    Navigator.of(context).pop();
  }
}
