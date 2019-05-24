import 'package:flutter/material.dart';
import 'package:todo_app/model/TodoItem.dart';
import 'package:todo_app/util/Database.dart';
// import 'package:todo_app/util/date_formatter.dart';
import '../util/date_formatter.dart';

// video 184
class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController _textEditingController = new TextEditingController();
  var db = new DatabaseHelper();
  final List<TodoItem> _itemList = <TodoItem> [];

  @override
  void initState() {
    super.initState();
    _readTodoList();
  }

  void _handleSubmit(String itemName) async {
    _textEditingController.clear();

    TodoItem todoItem = new TodoItem(itemName, dateFormatted()); 
    int savedItemId   = await db.saveItem(todoItem);

    TodoItem addedItem = await db.getItem(savedItemId);

    setState(() {
      _itemList.insert(0, addedItem);
      // _itemList.add(todoItem);
    });

    print("Item saved id: $savedItemId");
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black87,
      body: new Column(
        children: <Widget>[
          new Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              reverse: false,
              itemCount: _itemList.length,
              itemBuilder:(_, int index){
                return Card(
                  color: Colors.white10,
                  child: ListTile(
                    title: Text('${_itemList[index].itemName}', style: new TextStyle(color: Colors.white, fontSize: 18)),
                    subtitle: Text('Created on: ${_itemList[index].dateCreated}', style: new TextStyle(color: Colors.grey, fontSize: 13)),
                    onLongPress: () => _updateTodoItem(_itemList[index], index),
                    trailing: new Listener(
                      key: new Key(_itemList[index].itemName),
                      child: new Icon(Icons.check, color: Colors.greenAccent,),
                      onPointerDown: (pointerEvent) => _deleteTodoItem(_itemList[index].id, index),
                    ),
                  ),
                );
              },               
            ),
          ),
          new Divider(
            height: 1.0,
          )
        ],
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
    var alert = new AlertDialog(
      content: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textEditingController,
              autofocus: true,
              decoration: new InputDecoration(
                labelText: "Item",
                hintText: "eg. Read a book!",
                icon: Icon(Icons.note_add)
              ),
            ),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            _handleSubmit(_textEditingController.text);
            _textEditingController.clear();
          },
          child: Text('Save'),
        ),
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        )
      ],
    );
    showDialog(context: context, builder: (_){
      return alert;
    }); 
  }

  void _readTodoList() async{
    List items = await db.getItems();
    items.forEach( (item) {
      //TodoItem todoitem = TodoItem.map(item);
      setState(() {
        _itemList.add(TodoItem.map(item));
      });
    });
  }

  void _updateTodoItem(TodoItem todoitem, int index) async{
    var alert = new AlertDialog(
      title: Text('Update an item'),
      content: new Row(
        children: <Widget>[
          new Expanded(
            child: TextField(
              controller: _textEditingController,
              autofocus: true,
              decoration: new InputDecoration(
                labelText: 'Item',
                hintText: "eg. buy a book..",
                icon: Icon(Icons.update)
              ),
            ),
          )
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () async {
            // TodoItem itemUpdated = await db.getItem(todoitem.id);
            TodoItem newitemUpdated = TodoItem.fromMap(
              {
                "itemName": _textEditingController.text,
                "dateCreated": dateFormatted(),
                "id": todoitem.id
              }
            );
            _handlesubmittedUpdate(index, newitemUpdated);
            await db.updateItem(newitemUpdated);
            setState(() {
              _readTodoList();
            });
            Navigator.pop(context);
          },
          child: Text("Update"),
        ),
        new FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
      ],
    );

    showDialog(context: context, builder: (_){
      return alert;
    });
  }

  _handlesubmittedUpdate(int index, TodoItem todoitem) async {
    setState(() {
      _itemList.removeWhere( (element) {
        element.itemName == todoitem.itemName;
      });
    }); 
  }
  void _deleteTodoItem(int itemid, int index) async {
    await db.deleteItem(itemid);
    setState(() {
      _itemList.removeAt(index);
      _itemList.clear();
      _readTodoList();
    });
  }
}