import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {

  String _itemName;
  String _dateCreated;
  int _id;

  // constructors
  TodoItem(this._itemName, this._dateCreated);
  TodoItem.map(dynamic obj){
    this._itemName    = obj["itemName"];
    this._dateCreated = obj["dateCreated"];
    this._id          = obj["id"];
  }

  String get itemName    => this._itemName;
  String get dateCreated => this._dateCreated;
  int get id             => this._id;

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();

    map['itemName'] = _itemName;
    map['dateCreated'] = _dateCreated; 
    if(_id != null){
      map['id'] = _id;
    }
    return map;
  }

  TodoItem.fromMap(Map<String, dynamic> map){
    this._itemName    = map['itemName'];
    this._dateCreated = map['dateCreated']; 
    this._id          = map['id']; 
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Item name', style: new TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17)),
          Container(
            margin: EdgeInsets.only(top: 5.0),
            child: Text('Created at', style: new TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 14)),
          )
        ],
      ),
    );
  }
}