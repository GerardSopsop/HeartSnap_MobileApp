import "package:flutter/material.dart";

class TextInput extends StatefulWidget {
  const TextInput(
      {Key? key,
      required this.label,
      required this.controller,
      required this.type,
      this.editable = true,
      this.prefix = ""})
      : super(key: key);

  final bool editable;
  final String prefix;
  final String label;
  final TextEditingController controller;
  final TextInputType type;
  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          prefixText: widget.prefix,
          filled: true,
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(width: 2, color: Colors.green),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(width: 1, color: Colors.transparent),
          ),
          contentPadding:
              const EdgeInsets.only(bottom: 10, left: 8, top: 7, right: 8),
          isDense: true,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
          hintText: widget.label,
          fillColor: Colors.grey[200]),
      keyboardType: widget.type,
      controller: widget.controller,
      readOnly: !widget.editable,
    );
  }
}
