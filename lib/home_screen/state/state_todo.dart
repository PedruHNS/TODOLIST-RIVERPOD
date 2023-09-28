import 'package:todo_list_riverpod/home_screen/models/todo_model.dart';

sealed class StateTodo {
  final List<TodoModel> todos;

  StateTodo({required this.todos});
}

final class TodosListStateInitial extends StateTodo {
  TodosListStateInitial() : super(todos: []);
}

final class TodosListAdd extends StateTodo {
  TodosListAdd({required super.todos});
}

final class TodoListRemove extends StateTodo {
  TodoListRemove({required super.todos});
}

final class TodoListEdit extends StateTodo {
  TodoListEdit({required super.todos});
}
