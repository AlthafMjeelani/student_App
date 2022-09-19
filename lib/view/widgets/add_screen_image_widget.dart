import 'dart:io';
import 'package:db_sample/DB/model/enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/provider_imagepic.dart';

class AddScreenImageWidget extends StatelessWidget {
  const AddScreenImageWidget({
    Key? key,
    required this.imageprovider,
    required this.type,
    required this.photo,
  }) : super(key: key);

  final ImagePicProvider imageprovider;
  final Actiontype type;
  final String photo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20),
      child: type == Actiontype.editScreen
          ? CircleAvatar(
              backgroundImage: FileImage(
                File(Provider.of<ImagePicProvider>(context, listen: true)
                        .image
                        ?.path ??
                    photo),
              ),
              radius: 60,
            )
          : Provider.of<ImagePicProvider>(context, listen: true).image == null
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
    );
  }
}
