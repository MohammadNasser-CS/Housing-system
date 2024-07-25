import 'package:flutter/widgets.dart';

class FormFieldConfig {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? Function(String?)? validator;

  FormFieldConfig({
    required this.label,
    required this.hintText,
    required this.controller,
    required this.validator,
    required this.focusNode,
  });
}
