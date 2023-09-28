import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/todo_provider.dart';

class Filter extends ConsumerStatefulWidget {
  const Filter({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FilterState();
}

class _FilterState extends ConsumerState<Filter> {
  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      showSelectedIcon: false,
      segments: const <ButtonSegment<FilterSelect>>[
        ButtonSegment(
          value: FilterSelect.all,
          label: Text(
            'TODOS',
            style: TextStyle(fontSize: 14),
          ),
        ),
        ButtonSegment(
          value: FilterSelect.completed,
          label: Text(
            'COMPLETOS',
            style: TextStyle(fontSize: 14),
          ),
        ),
        ButtonSegment(
          value: FilterSelect.uncompleted,
          label: Text(
            'INCOMPLETOS',
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
      selected: <FilterSelect>{ref.watch(filterProvider)},
      onSelectionChanged: (Set<FilterSelect> select) {
        ref.read(filterProvider.notifier).state = select.first;
      },
    );
  }
}
