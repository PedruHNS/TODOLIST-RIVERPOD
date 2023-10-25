import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_riverpod/home_screen/state/todo_provider.dart';


enum FilterSelect {
  all,
  completed,
  uncompleted;
}


final filterProvider = StateProvider((ref) => FilterSelect.all);


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