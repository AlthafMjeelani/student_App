import 'dart:developer';
import 'dart:io';
import 'package:db_sample/DB/data_modal.dart';
import 'package:db_sample/DB/functions/db_function.dart';
import 'package:db_sample/DB/model/enum.dart';
import 'package:db_sample/providers/provider_imagepic.dart';
import 'package:db_sample/providers/search_provider.dart';
import 'package:db_sample/view/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home/home_screen.dart';
import '../widgets/add_screen_image_widget.dart';
import '../widgets/add_screen_widget.dart';

class AddScreen extends StatelessWidget {
  AddScreen({
    Key? key,
    this.name,
    this.age,
    this.mobile,
    this.domain,
    this.photo,
    this.id,
    required this.type,
    this.index,
  }) : super(key: key);

  final String? name;
  final String? age;
  final String? mobile;
  final String? domain;
  final String? photo;
  final String? id;
  int? index;
  final Actiontype type;

  final TextEditingController _userName = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _domain = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (type == Actiontype.editScreen) {
      _userName.text = name.toString();
      _age.text = age.toString();
      _mobile.text = mobile.toString();
      _domain.text = domain.toString();
    }
    final imageprovider = Provider.of<ImagePicProvider>(context, listen: false);
    if (type == Actiontype.addScreen) {
      imageprovider.image == null;
    }
    imageprovider.imageVisibility = false;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                AddScreenImageWidget(
                  imageprovider: imageprovider,
                  photo: photo.toString(),
                  type: type,
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
                      ElevatedButton.icon(
                        onPressed: () {
                          if (type == Actiontype.addScreen) {
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
                          } else {
                            if (formKey.currentState!.validate()) {
                              buttonSubmit(context);
                              imageprovider.imageVisibility = false;
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

    final student = StudentModel(
      username: _userName.text,
      age: _age.text,
      mobilenumber: _mobile.text,
      domain: _domain.text,
      photo: imageprovider.image?.path ?? photo.toString(),
      id: type == Actiontype.addScreen
          ? DateTime.now().microsecondsSinceEpoch.toString()
          : id.toString(),
    );
    type == Actiontype.addScreen
        ? finctionprovider
            .addStudent(student)
            .then((value) => imageprovider.image = null)
        : finctionprovider
            .updateList(index!.toInt(), student)
            .then((value) => imageprovider.image = null);

    if (type == Actiontype.editScreen) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
          (route) => false);
      SnackBarWidget().show(context, 'Records successfully Edited');
    } else {
      Provider.of<SearchProvider>(context, listen: false).getAll();
      SnackBarWidget().show(context, 'Records successfully Added');
      Navigator.of(context).pop();
    }
    log('saved');
  }
}
