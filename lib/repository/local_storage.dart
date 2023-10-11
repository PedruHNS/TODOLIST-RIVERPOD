import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_riverpod/home_screen/models/todo_model.dart';

import 'todo_repository_interface.dart';

final todoRepositoryProvider = Provider<TodoRepositoryInterface>(
  (ref) => LocalStorage(),
);

class LocalStorage implements TodoRepositoryInterface {
  Future<SharedPreferences> _openLocalStorage() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<void> deleteTodo(TodoModel todo) async {
    final prefs = await _openLocalStorage();
    prefs.remove(todo.id);
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    final prefs = await _openLocalStorage();
    prefs.setString(todo.id, todo.toJson());
  }

  @override
  Future<List<TodoModel>> loadTodo() async {
    final prefs = await _openLocalStorage();
    final keys = prefs.getKeys();
    return keys
        .map((key) => prefs.getString(key))
        .where((result) => result != null)
        .cast<String>()
        .map<TodoModel>(TodoModel.fromJson)
        .toList();
  }

  @override
  Future<void> saveTodo(TodoModel todo) async {
    final prefs = await _openLocalStorage();
    prefs.setString(todo.id, todo.toJson());
  }
}
