import 'package:flutter/material.dart';

class AddTextFormFeild extends StatelessWidget {
  const AddTextFormFeild({
    Key? key,
    required TextEditingController userName,
    required TextEditingController age,
    required TextEditingController mobile,
    required TextEditingController domain,
  })  : _userName = userName,
        _age = age,
        _mobile = mobile,
        _domain = domain,
        super(key: key);

  final TextEditingController _userName;
  final TextEditingController _age;
  final TextEditingController _mobile;
  final TextEditingController _domain;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Username is Empty';
            }
            return null;
          },
          controller: _userName,
          decoration: const InputDecoration(
              border: OutlineInputBorder(), labelText: 'FullName'),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty || value.length > 2) {
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
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty || value.length != 10) {
              return 'please enter 10 numbers';
            }
            return null;
          },
          keyboardType: TextInputType.number,
          controller: _mobile,
          decoration: const InputDecoration(
              border: OutlineInputBorder(), labelText: 'Mobile Number'),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
      ],
    );
  }
}
