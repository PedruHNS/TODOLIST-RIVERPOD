// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InputCustom extends ConsumerWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?) validator;
  const InputCustom({super.key, 
    required this.label,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      validator: validator,
      controller: controller,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
      border: const OutlineInputBorder(),
      labelText: label,
      ),

    );
  }
}
