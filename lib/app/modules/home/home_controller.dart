import 'package:mobx/mobx.dart';
import 'package:todolist/app/modules/home/models/todo_model.dart';
import 'package:todolist/app/modules/home/repositories/todo_repository_interface.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final ITodoRepository repository;

  @observable
  ObservableStream<List<TodoModel>> todoList;

  _HomeControllerBase(ITodoRepository this.repository) {
    getList();
  }

  @action
  getList() {
    todoList = repository.getTodos().asObservable();
  }

  Future save(TodoModel model) => repository.save(model);
  
 Future delete(TodoModel model) => repository.delete(model);
  
}
