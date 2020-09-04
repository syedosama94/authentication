import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActionBTN extends StatefulWidget {
  final Color color;
  final Function onTap;
  var text = new ValueNotifier<String>('');
  ActionBTN(this.onTap, String actionText, this.color) {
    text.value = actionText;
  }
  changeText(final newText) {
    this.text.value = newText;
    text.notifyListeners();
  }

  @override
  _ActionBTNState createState() =>
      // print('create state of action btn called');
      _ActionBTNState();
}

class _ActionBTNState extends State<ActionBTN> {
  String text;
  @override
  Widget build(BuildContext context) {
    // final _authService = Provider.of<AuthService>(context);
    print('build function of action btn called');
    return InkWell(
      onTap: widget.onTap(),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: widget.color, borderRadius: BorderRadius.circular(10)),
        child: Center(
            child: ValueListenableBuilder<String>(
          valueListenable: widget.text,
          builder: (context, value, child) {
            return Text(widget.text.value,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold));
          },
        )),
      ),
    );
  }

  setText(final String newText) => setState(() => text = newText);
}
