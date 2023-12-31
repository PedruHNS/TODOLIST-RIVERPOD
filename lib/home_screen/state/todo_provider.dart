import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_riverpod/home_screen/state/state_todo.dart';
import 'package:todo_list_riverpod/home_screen/models/todo_model.dart';
import 'package:todo_list_riverpod/repository/todo_repository_interface.dart';
import '../../repository/local_storage.dart';

final todoProvider = StateNotifierProvider<TodoNotifier, StateTodo>(
  (ref) {
    return TodoNotifier(
      todoRepository: ref.watch(todoRepositoryProvider),
    );
  },
);

// aqui fica a regra de negócio dos estados do Todo List
class TodoNotifier extends StateNotifier<StateTodo> {
  //abaixo passamos o estado inicial para o super
  TodoNotifier({required this.todoRepository}) : super(TodosListStateInitial());

  final TodoRepositoryInterface todoRepository;

  Future<void> getLocalStorage() async {
    final todos = await todoRepository.loadTodo();
    state = LoadTodos(todos: todos);
  }

  //adicionar uma tarefa na lista
  Future<void> todoAdd(TodoModel todo) async {
    //adicionando no localStorage
    await todoRepository.saveTodo(todo);
    //abaixo passamos um novo estado para o state.
    // esse estado representa a uma nova lista com uma nova tarefa
    state = TodosListAdd(todos: [
      ...state.todos, // aqui fazemos o spreed da lista que signifaca,
      //pega a lista do state atual
      todo, // estamos juntando a lista junto com uma nova tarefa
    ]);
  }

  //----------------------------------
  // removendo uma tarefa da nossa lista através do id
  void remove(String id) async {
    final todos = state.todos;
    final todoIndex = state.todos.indexWhere((todo) => todo.id == id);
    if (todoIndex < 0) return;

    final itemDelete = todos[todoIndex];

    await todoRepository.deleteTodo(itemDelete);

    final newListTodos = [
      ...todos.sublist(0, todoIndex),
      ...todos.sublist(todoIndex + 1)
    ];
    state = TodoListRemove(todos: newListTodos);
  }

  // -----------------------------------
  // função para marca a tarefa como completa ou incompleta através do ID
  Future<void> toggle(String id) async {
    final todos = state.todos;
    final itemIndex = todos.indexWhere((item) => item.id == id);
    if (itemIndex < 0) return;

    final item = todos[itemIndex];
    final edit = item.copyWith(isComplete: !item.isComplete);

    final todoNew = [
      ...todos.sublist(0, itemIndex),
      edit,
      ...todos.sublist(itemIndex + 1)
    ];
    await todoRepository.updateTodo(edit);
    state = TodoListEdit(todos: todoNew);
  }
}
