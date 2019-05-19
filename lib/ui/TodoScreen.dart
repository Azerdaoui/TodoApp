import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black87,
      body: new Column(

      ),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Colors.green,
        tooltip: 'New Item',
        child: new ListTile(
          title: Icon(Icons.add, color: Colors.white),
        ),
        onPressed: _showFormDialog,
      ),
    );
  }

  void _showFormDialog() {
  }
}