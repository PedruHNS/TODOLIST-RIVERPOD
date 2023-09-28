import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_riverpod/material_app.dart';


void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
