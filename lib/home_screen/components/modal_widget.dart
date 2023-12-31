import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_riverpod/home_screen/components/input/input_custom_widget.dart';
import 'package:todo_list_riverpod/home_screen/components/input/state_input_validator.dart';
import 'package:todo_list_riverpod/home_screen/models/todo_model.dart';
import 'package:uuid/uuid.dart';

import '../state/todo_provider.dart';

class Modal extends ConsumerStatefulWidget {
  const Modal({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ModalState();
}

class _ModalState extends ConsumerState<Modal> {
  final _controllerTitle = TextEditingController();
  final _controllerDescription = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controllerTitle.dispose();
    _controllerDescription.dispose();
    super.dispose();
  }

  void _todoAdd() {
    if (_formKey.currentState!.validate()) {
      ref.read(todoProvider.notifier).todoAdd(
            TodoModel(
              id: const Uuid().v4(),
              title: _controllerTitle.text,
              description: _controllerDescription.text,
              isComplete: false,
            ),
          );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Inserido com sucesso'),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 340,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 8,
                  width: 60,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InputCustom(
                    controller: _controllerTitle,
                    label: 'Título',
                    validator: (text) {
                      return ref
                          .read(validatorProvider.notifier)
                          .validator(text);
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InputCustom(
                  controller: _controllerDescription,
                  label: 'Descrição',
                  validator: (text) {
                    return ref.read(validatorProvider.notifier).validator(text);
                  },
                ),
              ),
              ElevatedButton(
                onPressed: _todoAdd,
                child: const Text('Criar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
