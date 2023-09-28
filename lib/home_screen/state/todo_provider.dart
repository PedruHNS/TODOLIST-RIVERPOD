import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_riverpod/home_screen/state/state_todo.dart';
import 'package:todo_list_riverpod/home_screen/models/todo_model.dart';

// enumador para selecionar o filtro
enum FilterSelect {
  all,
  completed,
  uncompleted;
}
// --------------------------

// aqui fica a regra de negócio dos estados do Todo List
class TodoNotifier extends StateNotifier<StateTodo> {
  //abaixo passamos o estado inicial para o super
  TodoNotifier() : super(TodosListStateInitial());

  //adicionar uma tarefa na lista
  void todoAdd(TodoModel todo) {
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
  void remove(String id) {
    // abaixo estamos acessando a lista de todos que esta no STATE
    // em seguida estamos fazendo um where para pegar somente os itens
    // que NÃO possuem o mesmo ID que foi passado na Função remove ou seja
    // capturamos todos as tarefas diferente do ID passado e depois transformamos
    // em lista pois o metodo where retorna um iterable
    final todo = state.todos.where((item) => item.id != id).toList();
    //após executar a linha acima passamos o estado TodoListRemove
    // com sua nova lista para o state
    state = TodoListRemove(todos: todo);
  }
  // -----------------------------------

  // função para marca a tarefa como completa ou incompleta através do ID
  void toggle(String id) {
    
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

    state = TodoListEdit(todos: todoNew);
  }
}

final filterProvider = StateProvider((ref) => FilterSelect.all);

final todoProvider = StateNotifierProvider<TodoNotifier, StateTodo>((ref) {
  return TodoNotifier();
});

final homeFilteredListProvider = StateProvider((ref) {
  final filter = ref.watch(filterProvider);
  final listTodos = ref.watch(todoProvider);

  final list = listTodos.todos;
  switch (filter) {
    case FilterSelect.all:
      return list;
    case FilterSelect.completed:
      return list.where((todo) => todo.isComplete == true).toList();
    case FilterSelect.uncompleted:
      return list.where((todo) => todo.isComplete == false).toList();
  }
  //ou//
  // return switch (filter) {
  //   FilterSelect.all => list,
  //   FilterSelect.completed => list.where((todo) => todo.isComplete).toList(),
  //   FilterSelect.uncompleted => list.where((todo) => !todo.isComplete).toList(),
  // };
});
