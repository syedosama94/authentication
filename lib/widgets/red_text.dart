import 'package:flutter/material.dart';

class RedText extends StatefulWidget {
  var text = new ValueNotifier<String>('');
  RedText(String actionText) {
    text.value = actionText;
  }
  changeText(final String newText) {
    this.text.value = newText;
    text.notifyListeners();
  }

  @override
  _RedTextState createState() => _RedTextState();
}

class _RedTextState extends State<RedText> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget.text,
        builder: (context, value, child) =>
            Text(widget.text.value, style: TextStyle(color: Colors.red)));
  }
}
