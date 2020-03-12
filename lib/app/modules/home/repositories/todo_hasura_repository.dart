import 'package:hasura_connect/hasura_connect.dart';
import 'package:todolist/app/modules/home/documents/todo_document.dart';
import 'package:todolist/app/modules/home/models/todo_model.dart';
import 'package:todolist/app/modules/home/repositories/todo_repository_interface.dart';

  class TodoHasuraRepository implements ITodoRepository {


    final HasuraConnect connect;

    TodoHasuraRepository(this.connect){

    }

  @override
  Future delete(TodoModel model) async{
   
    return  await connect.mutation(todosRemoverQuery, variables: {
      "id": model.id
    });
  }

  @override
  Stream<List<TodoModel>> getTodos() {
   
    return connect.subscription(todosQuery)
    .map((event){
      return (event['data']['todos'] as List).map( (json) {
        return TodoModel.fromJson(json);
      }).toList();
    });
  }

  @override
  Future save(TodoModel model) async {
   
    if(model.id == null){
      var data = await connect.mutation(todosInsertQuery, variables: {
        'title': model.title
      });

     return model.id = await data['data']['insert_todos']['returning'][0]['id'];
    } else {
     return await connect.mutation(todosUpdateQuery, variables: {
        "id": model.id,
        "title": model.title,
        "check": model.check
      });
    }
  }

}