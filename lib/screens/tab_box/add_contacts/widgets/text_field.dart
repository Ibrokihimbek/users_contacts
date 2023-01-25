import 'package:flutter/material.dart';

class TextfieldWidget extends StatelessWidget {
  final TextEditingController textController;
  final String word;
  const TextfieldWidget(
      {super.key, required this.word, required this.textController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextFormField(
        keyboardType: word == 'Name' ? TextInputType.text : TextInputType.phone,
        controller: textController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: word == "Name"
            ? ((value) => value != null && value.length < 2
                ? "Kamida 2 ta belgi kiriting!"
                : null)
            : ((value) => value != null && value.length < 12
                ? "Kamida 12 ta belgi kiriting!"
                : null),
        decoration: InputDecoration(
          suffixIcon: Icon(word == 'Name' ? Icons.person : Icons.phone),
          contentPadding: const EdgeInsets.only(left: 12),
          hintText: word,
          hintStyle: TextStyle(color: Colors.grey.shade400),
          helperStyle: const TextStyle(color: Colors.black26),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: BorderSide(
              width: 1,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.black)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.black)),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.black)),
        ),
      ),
    );
  }
}
