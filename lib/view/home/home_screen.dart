import 'dart:developer';

import 'package:db_sample/Screens/widgets/list_student_widget.dart';
import 'package:db_sample/provders/provider_imagepic.dart';
import 'package:db_sample/provders/search_provider.dart';
import 'package:flutter/material.dart';
import '../add/add_student_screen.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    log(' build called');

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        searchProvider.getAll();
      },
    );
    final TextEditingController searchController = TextEditingController();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ImagePicProvider>().image = null;
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (cxt) => AddScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: [
          Consumer<SearchProvider>(
            builder: (BuildContext context, value, Widget? child) {
              return value.visible == true
                  ? IconButton(
                      onPressed: () {
                        value.visibilitysearch();
                        log(value.visible.toString());
                        value.searchFilter('');
                      },
                      icon: const Icon(Icons.close),
                    )
                  : IconButton(
                      onPressed: () {
                        value.visibilitysearch();
                        log(value.visible.toString());
                      },
                      icon: const Icon(Icons.search),
                    );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<SearchProvider>(
          builder: (BuildContext context, value, Widget? child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                value.visible == true
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: searchController,
                          onChanged: (value) {
                            searchProvider.searchFilter(value);
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Search',
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      )
                    : const SizedBox(),
                Expanded(
                  child: ListStudentWidget(
                    controller: searchController,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
