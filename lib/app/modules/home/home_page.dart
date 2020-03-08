import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:todolist/app/modules/home/models/todo_model.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Observer(builder: (_) {
        if (controller.todoList.hasError) {
          return Center(
            child: RaisedButton(
              onPressed: () {
                controller.getList();
              },
              child: Text("Error"),
            ),
          );
        }

        if(controller.todoList.data == null) {
          return Center(child: CircularProgressIndicator(),);
        }

        List<TodoModel> lista = controller.todoList.data;

        return ListView.builder(
            itemCount: lista.length,
            itemBuilder: (context, index) {

              TodoModel model = lista[index];
              return CheckboxListTile(
                title: Text(model.title),
                value: model.check,
                onChanged: (check){
                  model.check = check;
                  model.save();
                },
              );
            });
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }

 _showDialog(){
   
 }

}
