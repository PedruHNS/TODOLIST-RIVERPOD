import 'package:flutter_riverpod/flutter_riverpod.dart';

final validatorProvider = StateNotifierProvider<ValidadorNotifier, String?>(
    (ref) => ValidadorNotifier());

class ValidadorNotifier extends StateNotifier<String?> {
  ValidadorNotifier() : super(null);

  String? validator(String? text) {
    if (text == null || text.isEmpty) {
      return 'Campo Invalido';
    } else {
      return null;
    }
  }
}