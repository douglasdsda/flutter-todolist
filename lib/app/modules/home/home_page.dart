import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:todolist/app/modules/home/components/item_tiles.dart';
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

        if (controller.todoList.data == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<TodoModel> lista = controller.todoList.data;

        return ListView.builder(
            itemCount: lista.length,
            itemBuilder: (context, index) {
              TodoModel model = lista[index];
              return ItemTile(
                model: model,
                onTap: (){
                  _showDialog(model);
                },
              );
            });
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        child: Icon(Icons.add),
      ),
    );
  }

  _showDialog([TodoModel model]) {
    model ??= TodoModel();
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(model.title != '' ? 'Edição' : 'Novo'),
            content: TextFormField(
              initialValue: model.title,
              onChanged: (value) => model.title = value,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Escreva...'),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Modular.to.pop();
                  },
                  child: Text('Cancelar')),
              FlatButton(
                  onPressed: () async {
                    await controller.save(model);
                    Modular.to.pop();
                  },
                  child: Text('Adicionar'))
            ],
          );
        });
  }
}
