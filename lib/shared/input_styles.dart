import 'package:fishes/shared/palette.dart';
import 'package:flutter/material.dart';

class InputStyles {
  static final OutlineInputBorder borderSide = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: const BorderSide(
      color: Palette.grayLight,
      strokeAlign: 2,
    ),
  );
}
