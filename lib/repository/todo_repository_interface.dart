import '../home_screen/models/todo_model.dart';

abstract interface class TodoRepositoryInterface {
  
  Future<List<TodoModel>> loadTodo();
  Future<void>saveTodo(TodoModel todo);
  Future<void>updateTodo(TodoModel todo);
  Future<void>deleteTodo(TodoModel todo);
  
}


