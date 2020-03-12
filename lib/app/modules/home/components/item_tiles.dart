import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todolist/app/modules/home/home_controller.dart';
import 'package:todolist/app/modules/home/models/todo_model.dart';

class ItemTile extends StatelessWidget {
  final TodoModel model;
  final Function onTap;

  ItemTile({Key key, this.model, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(model.title),
      leading: IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: () {
            Modular.get<HomeController>().delete(model);
          }),
      trailing: Checkbox(
        value: model.check,
        onChanged: (check) {
          model.check = check;
          Modular.get<HomeController>().save(model);
        },
      ),
      onTap: () {
        onTap;
      },
    );
  }
}
