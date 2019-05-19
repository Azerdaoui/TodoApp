import 'package:flutter/material.dart';

import 'package:todo_app/ui/TodoScreen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.black54,
        title: Text('Todo list!'),
        centerTitle: true,
      ),
      body: new TodoScreen(),
    );
  }
}