 
import 'package:hasura_connect/hasura_connect.dart';
import 'package:todolist/app/modules/home/home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todolist/app/modules/home/home_page.dart';
 
import 'package:todolist/app/modules/home/repositories/todo_hasura_repository.dart';
import 'package:todolist/app/modules/home/repositories/todo_repository_interface.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController(i.get())),
       // Bind<ITodoRepository>((i) => TodoFirebaseRepository(Firestore.instance)),
       Bind<ITodoRepository>((i) => TodoHasuraRepository(i.get())),
       Bind((i) => HasuraConnect('https://flutter-todolist.herokuapp.com/v1/graphql'))
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => HomePage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
