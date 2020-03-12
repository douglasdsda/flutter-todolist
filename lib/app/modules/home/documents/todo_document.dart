const String todosQuery = '''
subscription MyQuery {
  todos(order_by: {id: desc}) {
    check
    id
    title
  }
}


''';


const String todosInsertQuery = '''
mutation InsertTodo(\$title: String) {
  insert_todos(objects: {title: \$title}) {
    returning {
      id
    }
  }
}

''';

const String todosUpdateQuery = '''
 mutation UpdateTodos(\$id: Int, \$title: String, \$check: Boolean) {
  update_todos(where: {id: {_eq: \$id}}, _set: {check: \$check, title: \$title, id: \$id}) {
    affected_rows
  }
}


''';


const String todosRemoverQuery = '''
 mutation DeleteTodos(\$id: Int) {
  delete_todos(where: {id: {_eq: \$id}}) {
    affected_rows
  }
}

''';

