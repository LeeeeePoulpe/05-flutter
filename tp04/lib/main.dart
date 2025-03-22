import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tp02/demineur.dart';

// void main() {
//   runApp(const DemineurApp());
// }

void main() {
  runApp(ProviderScope(
      child: MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const DemineurApp(),
  )));
}
