import 'dart:io';
import 'package:db_sample/DB/data_modal.dart';
import 'package:db_sample/DB/functions/db_function.dart';
import 'package:db_sample/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Editscreen extends StatefulWidget {
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
  String photo;
  @override
  State<Editscreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<Editscreen> {
  Future<void> getimage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    } else {
      final imageTemp = File(image.path);
      setState(
        () {
          widget.photo = imageTemp.path;
        },
      );
    }
  }

  bool imageAlert = false;
  late TextEditingController _userName;
  late TextEditingController _age;
  late TextEditingController _mobile;
  late TextEditingController _domain;
  @override
  void initState() {
    _userName = TextEditingController(text: widget.name);
    _age = TextEditingController(text: widget.age);
    _mobile = TextEditingController(text: widget.mobile);
    _domain = TextEditingController(text: widget.domain);
    super.initState();
  }

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
                    child: CircleAvatar(
                      backgroundImage: FileImage(
                        File(widget.photo),
                      ),
                      radius: 60,
                      child: const Icon(Icons.image),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        getimage();
                      },
                      icon: const Icon(Icons.image),
                    ),
                    const Text('Add image'),
                  ],
                ),
                Visibility(
                  visible: imageAlert,
                  child: const Text(
                    'please Upload Image',
                    style: TextStyle(color: Colors.red),
                  ),
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
                            buttonSubmit();
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

  Future<void> buttonSubmit() async {
    final student = StudentModel(
      username: _userName.text,
      age: _age.text,
      mobilenumber: _mobile.text,
      domain: _domain.text,
      photo: widget.photo,
    );

    await updateList(widget.index, student);
    if (!mounted) {
      return;
    }
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
        (route) => false);
  }
}
