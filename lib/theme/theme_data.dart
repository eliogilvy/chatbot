import 'package:flutter/material.dart';
import 'package:chat_app/theme/text_scheme.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  textTheme: textTheme,
  colorSchemeSeed: Colors.blue,
);

final darktheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  textTheme: textTheme,
  colorSchemeSeed: Colors.purple,
);
