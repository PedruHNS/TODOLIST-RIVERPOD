import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardWidget extends ConsumerWidget {
  final String title;
  final String description;
  final bool isComplete;
  const CardWidget(
      {super.key,
      required this.title,
      required this.description,
      required this.isComplete});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: isComplete ? Colors.grey : Colors.black,
              decoration: isComplete ? TextDecoration.lineThrough : null,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            description,
            style: TextStyle(
              fontSize: 18,
              decoration: isComplete ? TextDecoration.lineThrough : null,
              color: isComplete ? Colors.grey : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
