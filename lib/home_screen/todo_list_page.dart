import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_riverpod/home_screen/components/ListTodo/todo_list_widget.dart';
import 'package:todo_list_riverpod/home_screen/components/modal_widget.dart';
import 'package:todo_list_riverpod/home_screen/state/todo_provider.dart';


import 'components/filter/filter.dart';

class TodoListPage extends ConsumerStatefulWidget {
  const TodoListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoListPageState();
}

class _TodoListPageState extends ConsumerState<TodoListPage> {
  @override
  void initState() {
    ref.read(todoProvider.notifier).getLocalStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List C/ Riverpod'),
        backgroundColor: const Color.fromARGB(255, 201, 118, 248),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Filter(),
          ),
          SizedBox(height: 12),
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(5.0),
            child: TodoListWidget(),
          )),
          SizedBox(height: 12),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (_) {
                return const Modal();
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
