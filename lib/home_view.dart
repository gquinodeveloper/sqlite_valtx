import 'package:app_sqlite_valtx/providers/db_provider.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
const HomeView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("SQLite"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final response  = await DBProvider.db.insertLink("https://pub.dev/packages/path_provider");
          print(response);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}