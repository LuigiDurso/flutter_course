import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final int maxLines;
  final String label;
  final String text;
  final FocusNode focusNode;
  final TextInputType? textInputType;
  final Function(String)? onFieldSubmitted;
  final ValueChanged<String> onChanged;
  final String? Function(String?)? validator;

  const TextFieldWidget({
    Key? key,
    this.maxLines = 1,
    this.onFieldSubmitted,
    this.validator,
    this.textInputType = TextInputType.text,
    required this.label,
    required this.text,
    required this.focusNode,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          TextFormField(
            initialValue: text,
            focusNode: focusNode,
            onFieldSubmitted: onFieldSubmitted,
            validator: validator,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            maxLines: maxLines,
            textInputAction: onFieldSubmitted != null ?
            TextInputAction.next : TextInputAction.done,
            keyboardType: textInputType,
            onChanged: onChanged,
          ),
        ],
      );
}