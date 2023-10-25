import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_riverpod/home_screen/components/filter/state_filter.dart';

import '../../state/todo_provider.dart';
import '../card_custom_widget.dart';

class TodoListWidget extends ConsumerWidget {
  const TodoListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateTodo = ref.watch(homeFilteredListProvider);
  
    final todos = stateTodo;

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (_, index) {
        final item = todos[index];

        return Dismissible(
          key: Key('ITEM${item.id}'),
          onDismissed: (direction) =>
              ref.read(todoProvider.notifier).remove(item.id),
          child: Row(
            children: [
              Checkbox(
                value: item.isComplete,
                onChanged: (value) {
                  ref.read(todoProvider.notifier).toggle(item.id);
                },
              ),
              Expanded(
                child: Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    return CardWidget(
                      title: item.title,
                      description: item.description,
                      isComplete: item.isComplete,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
